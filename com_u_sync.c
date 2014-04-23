/*

    This work was produced at the University of California, Lawrence Livermore
    National Laboratory (UC LLNL) under contract no. W-7405-ENG-48 (Contract
    48) between the U.S. Department of Energy (DOE) and The Regents of the
    University of California (University) for the operation of UC LLNL. The
    rights of the Federal Government are reserved under Contract 48 subject to
    the restrictions agreed upon by the DOE and University as allowed under DOE
    Acquisition Letter 97-1.

    DISCLAIMER

    This work was prepared as an account of work sponsored by an agency of the
    United States Government. Neither the United States Government nor the
    University of California nor any of their employees, makes any warranty,
    express or implied, or assumes any liability or responsibility for the
    accuracy, completeness, or usefulness of any information, apparatus,
    product, or process disclosed, or represents that its use would not
    infringe privately-owned rights.  Reference herein to any specific
    commercial products, process, or service by trade name, trademark,
    manufacturer or otherwise does not necessarily constitute or imply its
    endorsement, recommendation, or favoring by the United States Government or
    the University of California. The views and opinions of authors expressed
    herein do not necessarily state or reflect those of the United States
    Government or the University of California, and shall not be used for
    advertising or product endorsement purposes.

    NOTIFICATION OF COMMERCIAL USE

    Commercialization of this product is prohibited without notifying the
    Department of Energy (DOE) or Lawrence Livermore National Laboratory
    (LLNL).

    UCRL-CODE-2001-028


    com.c
    
    Description:

      This test uses MPI_Send and MPI_Recv to determine unidirectional
      bandwidth and MPI_Sendrecv to determine bidirectional bandwidth 
      between pairs of MPI processes.  It can be used to measure 
      out-of-SMP bandwidth and bisectional bandwidth, provided the MPI 
      processes are properly allocated.

      The average communication time is calculated by dividing 
      the longest time sample of all the processes by the number
      of communication operations for 1 process.
      
      The bandwidth is calculated by dividing the total of all message
      sizes for all communicating process pairs by the longest time sample.

*/


#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <hmpi.h>
#include <unistd.h>
#include <stdint.h>
#include "util.h"
#include "sm_malloc.c"

static char* outputFormat     = "  %-14s  %9d  %20d  %15.3f  %12.3f\n";
static char* outputCharFormat = "  %-14s  %9s  %20s  %15s  %12s\n";
static char* command;


double runBicomTest (int procs, int bufsize, int iters, int rank, 
                     int wsize, int procsPerNode, char allocPattern, 
                     int useBarrier, int useNearestRank, MPI_Comm *activeComm);
double runUnicomTest(int procs, int bufsize, int iters, int rank, 
                     int wsize, int procsPerNode, char allocPattern, 
                     int useBarrier, int useNearestRank, MPI_Comm *activeComm);
void printUse       (void);
void printParameters(int iters, int messStart, int messStop, int messFactor, 
                     char *procFile, int procsPerNode, 
                     char allocPattern, int useBarrier);
void printReportHeader(void);

#ifndef LINESIZE
#   define LINESIZE 64
#endif

#ifndef BLOCKSIZE
#   define BLOCKSIZE 4096
#endif

#pragma pack(1)
typedef struct ReqInfo{
   char* buffer;  //8bytes
   //char* r_buffer;  //8bytes
   int* sync ;      //4 byte int for synchronization
   int* offset ;  //offset to a block

} ReqInfo ;

ReqInfo* req_array ;

int main(int argc, char *argv[])
{
  double minTime        = 99999.0;
  double testTime       = 0.0;
  double maxBidirBw     = 0.0;
  double maxUnidirBw    = 0.0;
  int    maxBidirSize   = 0;
  int    maxUnidirSize  = 0;
  char*  procFile       = NULL;
  int*   procList       = NULL;
  int    procListSize;
  int    rank, wsize, iters, procs;
  int    messStart, messStop, messFactor, messSize;
  int    procsPerNode, totalops, procIdx;
  int    useBarrier, printPairs, useNearestRank, dummy;
  double currBw;
  char   allocPattern;
  MPI_Comm activeComm;

  command = argv[0];

  MPI_Init(&argc, &argv);

  MPI_Comm_size(MPI_COMM_WORLD, &wsize);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  if ( !processArgs(argc, argv, rank, wsize, &iters, &dummy,
                    &messStart, &messStop, &messFactor, 
                    &procFile, &procsPerNode, &allocPattern, 
                    &printPairs, &useBarrier, &useNearestRank) )
  {
    if ( rank == 0 )
      printUse();

    MPI_Finalize();
    exit(-1);
  }

  if ( ! getProcList(procFile, wsize, &procList, &procListSize,
                     procsPerNode, allocPattern) )
  {
    if ( procFile )
      printf("Failed to get process list from file %s.\n", procFile);
    else
      printf("Failed to allocate process list.\n");

    exit(-1);
  }

  if ( rank == 0 )
    printReportHeader();


  //Set up intra-node shared memory structures.
  if(rank == 0) {
        //One rank per node allocates shared send request lists.
        req_array = malloc(wsize*sizeof(ReqInfo));
        /*if(!IS_SM_BUF((void*)req_array)){
            printf("Failed to allocate from SM region :%p \n", req_array);
            exit(-1);
        }*/
  }
  //broadcast address of the pointer variable so that each rank has access to it
  MPI_Bcast(&req_array , 1, MPI_LONG, 0, MPI_COMM_WORLD);
  //printf("Broadcasting of shared mem region complete! rank : %d  region_addr : %lu region_ptr : %lu \n", rank, &req_array, req_array);
  //printf("Access shm region ! rank : %d  region for sync : %lu  \n", rank, req_array[rank].sync);
 /* 
  if(rank == 0){
	char* comBuf  = (char*)malloc(10);
	memset(comBuf, 1, 10);
	req_array[30].buffer = comBuf ;
	comBuf[0] = 'n';
        req_array[30].sync = malloc(sizeof(int));
        req_array[30].sync[0] = 12;
	printf("rank : %d done sending buff ptr : %p  sync ptr : %p \n",rank, comBuf, req_array[30].sync );
        printf("sleeping ! pid() %d \n", getpid());
	sleep(40000);
  }else if(rank == 30){
	while(req_array[30].sync == NULL){
	
	}

	while(req_array[30].sync[0] != 12){
	
	}
	printf("rank : %d  buffer value: %c sync value : %d  buff ptr : %p  sync ptr : %p  \n",
		rank, req_array[30].buffer[0], req_array[30].sync[0], req_array[30].buffer, req_array[30].sync );
        printf("sleeping ! pid() %d \n", getpid());
		sleep(40000);
  } 
  MPI_Barrier(MPI_COMM_WORLD);
  return 0;*/
  for ( procIdx = 0; procIdx < procListSize; procIdx++ )
  {
    procs = procList[procIdx];

    if ( rank == 0 && printPairs )
    {
      printActivePairs(procs, rank, wsize, procsPerNode, 
                       allocPattern, useNearestRank);
    }

    /*  Create Communicator of all active processes  */
    createActiveComm(procs, rank, wsize, procsPerNode, 
                     allocPattern, printPairs, useNearestRank, &activeComm);

    for ( messSize = messStart; messSize <= messStop; 
          messSize *= messFactor )
    {
      testTime = runUnicomTest(procs, messSize, iters, rank, 
                               wsize, procsPerNode, allocPattern, 
                               useBarrier, useNearestRank, &activeComm);

      if ( rank == 0 && testTime > 0 )
      {
        totalops   = iters * (procs/2);
        currBw = ((double)totalops*(double)messSize/testTime)/1000000;

        if ( currBw > maxUnidirBw )
        {
          maxUnidirBw   = currBw;
          maxUnidirSize = messSize;
        }

        if ( testTime < minTime )
          minTime = testTime;
      }
    }

    if ( activeComm != MPI_COMM_NULL )
      MPI_Comm_free(&activeComm);

    if ( rank == 0 )
      printf("\n");
  }
  
  /*for ( procIdx = 0; procIdx < procListSize; procIdx++ )
  {
    procs = procList[procIdx];

    if ( rank == 0 && printPairs )
    {
      printActivePairs(procs, rank, wsize, procsPerNode, 
                       allocPattern, useNearestRank);
    }

    // Create Communicator of all active processes
    createActiveComm(procs, rank, wsize, procsPerNode, 
                     allocPattern, printPairs, useNearestRank, &activeComm);

    for ( messSize = messStart; messSize <= messStop; 
          messSize *= messFactor )
    {
      testTime = runBicomTest(procs, messSize, iters, rank,
                              wsize, procsPerNode, allocPattern,
                              useBarrier, useNearestRank, &activeComm);

      if ( rank == 0 && testTime > 0 )
      {
        totalops   = iters * procs;
        currBw = (((double)totalops*(double)messSize)/testTime)/1000000;

        if ( currBw > maxBidirBw )
        {
          maxBidirBw   = currBw;
          maxBidirSize = messSize;
        }

        if ( testTime < minTime )
          minTime = testTime;
      }
    }

    if ( activeComm != MPI_COMM_NULL )
      MPI_Comm_free(&activeComm);

    if ( rank == 0 )
      printf("\n");
  }   */


  if ( rank == 0 )
  {
    printf("Max Unidirectional Bandwith :  %13.2f for message size of %7d bytes\n",
           maxUnidirBw, maxUnidirSize);
    printf("Max  Bidirectional Bandwith :  %13.2f for message size of %7d bytes\n",
           maxBidirBw, maxBidirSize);

    printParameters(iters, messStart, messStop, messFactor, 
                    procFile, procsPerNode, allocPattern, useBarrier);
    free(req_array);
  }

  printReportFooter(minTime, rank, wsize, procsPerNode, useNearestRank);
  
  free(procList);

  MPI_Finalize();

  exit(0);
}


double runUnicomTest(int procs, int bufsize, int iters, int rank, 
                     int wsize, int procsPerNode, char allocPattern, 
                     int useBarrier, int useNearestRank, MPI_Comm *activeComm)
{
  int i, currtarg;
  double diff;
  double start, maxtime;
  MPI_Status stat;
  char *comBuf;
  double totalops;

  currtarg = getTargetRank(rank, wsize, procsPerNode, useNearestRank);

  diff     = 0;
  maxtime  = 0;

  if ( isActiveProc(rank, wsize, procsPerNode, procs, 
                    allocPattern, useNearestRank) )
  {
    if(bufsize < BLOCKSIZE){
        comBuf = memalign( LINESIZE, bufsize + sizeof(int));

        //printf("cpoint1 rank: %d wsize : %d  \n", rank, wsize);
        memset(comBuf, 0, bufsize);
        req_array[currtarg].sync = comBuf + bufsize ;
	
        //printf("cpoint2 rank: %d sync addr : %p \n", rank, req_array[currtarg].sync);
        req_array[currtarg].sync[0] = 0;
        //printf("cpoint3 rank: %d \n", rank);
    }else{
        comBuf  = (char*)malloc(bufsize);
        memset(comBuf, 0, bufsize);

        //allocate memory for sync flags both this rank and the target
        req_array[currtarg].sync = malloc(sizeof(int));
        req_array[currtarg].sync[0] = 0;
        //req_array[rank].sync = malloc(sizeof(int));
        //req_array[rank].sync[0] = 0;

        //we need offset for request going for target for synergistic transfer
        req_array[currtarg].offset = malloc(sizeof(int));
        req_array[currtarg].offset[0] = 0;
        //initialize
        //req_array[rank].offset[0] = 0;
    }

    //To do
    /*  Ensure communication paths have been initialized
    if ( rank < currtarg )
      MPI_Send(comBuf, bufsize, MPI_CHAR, currtarg, 0, MPI_COMM_WORLD);
    else 
    {
      MPI_Recv(comBuf, bufsize, MPI_CHAR, currtarg, 0, 
               MPI_COMM_WORLD, &stat);
    }   */

    //generic_barrier(*activeComm);
    //generic_barrier(*activeComm);
    MPI_Barrier(*activeComm);
    MPI_Barrier(*activeComm);

    //printf("cpoint4 rank: %d \n", rank);
    if ( rank < currtarg )
    {
      /*  Time operation loop  */
      start = MPI_Wtime();
      for ( i = 0; i < iters; i++ )  {
            //wait untill receiver completes
            while(req_array[currtarg].sync[0] != 0) ;
            if(bufsize < BLOCKSIZE){
    		//printf("cpoint5 rank: %d sync addr : %p \n", rank, req_array[currtarg].sync);
                req_array[currtarg].buffer = comBuf;
                // sender indicate receiver for data to be fetched
                req_array[currtarg].sync[0] = 1;
    		//printf("cpoint6 rank: %d sync addr : %p sync value : %d \n", rank, req_array[currtarg].sync,  req_array[currtarg].sync[0]);
            	//printf("sleeping ! pid() %d \n", getpid());
		//sleep(40000);
	      }else{
              volatile size_t* offsetptr = req_array[currtarg].offset;
              size_t offset;

              //wait untill receiver completes
              while(req_array[currtarg].sync[0] != 0) ;

              req_array[currtarg].buffer = comBuf;
              uintptr_t sbuf = (uintptr_t) comBuf ;
              // sender indicate receiver for data to be fetched
              req_array[currtarg].sync[0] = 1;

              //wait until reciever setup the transfer for synergistic protocol
              while(req_array[rank].sync[0] != 1) ;
              uintptr_t rbuf = (uintptr_t) req_array[rank].buffer ;
	
              //reset the flag for this sender for the purpose of next iteration
              req_array[rank].sync[0] = 0;
              //length to copy is min of len - offset and BLOCK_SIZE
              while((offset = __sync_fetch_and_add(offsetptr, BLOCKSIZE)) < bufsize) {
                  size_t left = bufsize - offset;
                  memcpy((void*)(rbuf + offset), (void*)(sbuf + offset),
                          (left < BLOCKSIZE ? left : BLOCKSIZE));
              }
    	      //if(i == 0 || i == (iters - 1)) printf("cpoint i: %d  rank: %d target: %d sbuf: %p rbuf: %p \n",i , rank, currtarg, sbuf, rbuf);

//                MPI_Send(comBuf, bufsize, MPI_CHAR, currtarg, 0, MPI_COMM_WORLD);
            }
      }
    }
    else 
    {
      //Reciever code
      start = MPI_Wtime();
      for ( i = 0; i < iters; i++ )
      {
            if(bufsize < BLOCKSIZE){
    		//printf("cpoint7 rank: %d sync addr : %p  \n", rank, req_array[rank].sync);
            	//printf("sleeping ! pid() %d \n", getpid());
		//sleep(40000);
                //wait until sync flag is is set
                while(req_array[rank].sync[0] != 1) ;
    		//printf("cpoint8 rank: %d \n", rank);
                // ready to recieve
                memcpy((void*)comBuf, (void*)req_array[rank].buffer, bufsize);
    		//printf("cpoint9 rank: %d \n", rank);
                //completed
                req_array[rank].sync[0] = 0;
    		//printf("cpoint10 rank: %d \n", rank);
            }else{

              volatile size_t* offsetptr = req_array[rank].offset;
              size_t offset;

              //wait untill sync flag is is set
              while(req_array[rank].sync[0] != 1) ;


              //reciever now ready to setup the transfer for synergistic protocol
              uintptr_t rbuf = (uintptr_t) comBuf ;
              uintptr_t sbuf = (uintptr_t) req_array[rank].buffer ;
              req_array[currtarg].buffer = rbuf;

              // reciever indicate sender to engage in synergistic protocol
              req_array[currtarg].sync[0] = 1;

              //length to copy is min of len - offset and BLOCK_SIZE
              while((offset = __sync_fetch_and_add(offsetptr, BLOCKSIZE)) < bufsize) {
                  size_t left = bufsize - offset;
                  memcpy((void*)(rbuf + offset), (void*)(sbuf + offset),
                          (left <  BLOCKSIZE ? left : BLOCKSIZE));
              }
    	      //if(i == 0 || i == (iters - 1)) printf("cpoint i: %d  rank: %d target: %d sbuf: %p rbuf: %p \n",i , rank, currtarg, sbuf, rbuf);
              //indicate to sender that recieve is complete now
              req_array[rank].sync[0] = 0;

            }

      }
    }

    //printf("cpoint11 rank: %d \n", rank);
    if ( useBarrier )
      MPI_Barrier(*activeComm);
      //generic_barrier(*activeComm);

    diff = MPI_Wtime() - start;

    free(comBuf);
    if(bufsize >= BLOCKSIZE) {
	 free(req_array[rank].sync);
   	 free(req_array[rank].offset);}
  }

  //printf("cpoint12 rank: %d \n", rank);
  MPI_Barrier(MPI_COMM_WORLD);

  /*  Get maximum sample length  */
  MPI_Reduce(&diff, &maxtime, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

  //printf("cpoint13 rank: %d \n", rank);
  if ( rank == 0 )
  {
    totalops = iters * (procs/2);

    /*
      Bandwidth is calculated as :
      
        ((# of processes/2) * operations per time sample * message size)
        ------------------------------------------------------------
                  maximum sample length of all processes
    */

    if ( maxtime > 0 )
    {
      printf(outputFormat, "Unidirectional", procs, bufsize, 
             ((double)totalops*(double)bufsize/maxtime)/1000000,
             maxtime/iters/2*1000000);
    }
    else
    {
      printf("Invalid measurement.  Increase number of operation per measurement.\n");
    }
  }

  return maxtime;
}


double runBicomTest(int procs, int bufsize, int iters, int rank, 
                    int wsize, int procsPerNode, char allocPattern, 
                    int useBarrier, int useNearestRank, MPI_Comm *activeComm)
{
  int i, currtarg;
  double start, diff, max;
  char *sendbuf, *recvbuf;
  double totalops;
  MPI_Status stat;

  currtarg = getTargetRank(rank, wsize, procsPerNode, useNearestRank);
  diff     = 0;

  if ( isActiveProc(rank, wsize, procsPerNode, procs, 
                    allocPattern, useNearestRank) ) 
  {
    sendbuf  = (char*)malloc(bufsize);
    recvbuf  = (char*)malloc(bufsize);

    memset(sendbuf, 0, bufsize);
    memset(recvbuf, 0, bufsize);

    /*  Ensure communication paths have been initialized  */
    MPI_Sendrecv(sendbuf, bufsize, MPI_CHAR, currtarg, 0, 
                 recvbuf, bufsize, MPI_CHAR, currtarg, 0, 
                 MPI_COMM_WORLD, &stat);

    //generic_barrier(*activeComm);
    MPI_Barrier(*activeComm);
    //generic_barrier(*activeComm);
    MPI_Barrier(*activeComm);

    if ( rank < currtarg ){
            /*  Time operation loop  */
            start = MPI_Wtime();

            for ( i = 0; i < iters; i++ )
            {
              //MPI_Send(&comBuf, 0, MPI_INT, currtarg, 0, MPI_COMM_WORLD);
              //MPI_Recv(&comBuf, 0, MPI_INT, currtarg, 0, MPI_COMM_WORLD, &stat);
            }
          }
          else
          {
            /*  Time operation loop  */
            start = MPI_Wtime();

            for ( i = 0; i < iters; i++ )
            {
              //MPI_Recv(&comBuf, 0, MPI_INT, currtarg, 0, MPI_COMM_WORLD, &stat);
              //MPI_Send(&comBuf, 0, MPI_INT, currtarg, 0, MPI_COMM_WORLD);
            }
          }



    /*  Time operation loop  */
//    start = MPI_Wtime();

//    for ( i = 0; i < iters; i++ )
//    {
//      MPI_Sendrecv(sendbuf, bufsize, MPI_CHAR, currtarg, 0,
//                   recvbuf, bufsize, MPI_CHAR, currtarg, 0,
//                   MPI_COMM_WORLD, &stat);
//    }

    if ( useBarrier )
      MPI_Barrier(*activeComm);
      //generic_barrier(*activeComm);

    diff = MPI_Wtime() - start;

    free(sendbuf);
    free(recvbuf);
  }

  MPI_Barrier(MPI_COMM_WORLD);

  /*  Get maximum sample length  */
  MPI_Reduce(&diff, &max, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

  if ( rank == 0 )
  {
    totalops   = (double)(iters * procs);

    /*
      Bandwidth is calculated as :
      
        (# of processes * operations per time sample * message size)
        ------------------------------------------------------------
                  maximum sample length of all processes
    */

    if ( max > 0 )
    {
      printf(outputFormat, "Bidirectional", procs, bufsize, 
             ((double)totalops*(double)bufsize/max)/1000000,
             max/iters*1000000);
    }
    else
    {
      printf("Invalid measurement.  Increase number of operation per measurement.\n");
    }
  }

  return max;
}


void printUse(void)
{
  printf("\n%s : MPI interprocess communication bandwidth benchmark\n\n", command);
  printf("  syntax: %s [OPTION]...\n\n", command);
  printf("    -b [message start size]                        default=%d\n", MESS_START_DEF);
  printf("    -e [message stop  size]                        default=%d\n", MESS_STOP_DEF);
  printf("    -f [process count source file]\n");
  printf("    -o [number of operations between measurements]\n");
  printf("    -p [allocate processes: c(yclic) or b(lock)]   default=%c\n", ALLOC_DEF);
  printf("    -s [message size increase factor]              default=%d\n", MESS_FACTOR_DEF);
  printf("    -t [processes per SMP]\n");
  printf("    -h : print use information\n");
  printf("    -i : print process pair information            default=%s\n",
        PRINT_PAIRS_DEF ? "true" : "false" );
  printf("    -n : do not use barrier within measurement     default=%s\n",
        USE_BARRIER_DEF ? "barrier used" : "barrier not used");
  printf("    -r : partner processes with nearby rank        default=%s\n",
        NEAREST_RANK_DEF ? "true" : "false" );
  printf("\n");
}



void printReportHeader(void)
{
  char buf[128];
  size_t i;

  printf("\nUnidirectional and Bidirectional Communication Test\n\n");
  sprintf(buf, outputCharFormat, "Test", "Processes", "Message Size (bytes)", 
          "Bandwidth (MB)", "Op time (us)");
  printf("%s", buf);

  for ( i = 1; i < strlen(buf); i++ )
    putchar('-');

  putchar('\n');
}


void printParameters(int iters, int messStart, int messStop, int messFactor, 
                char *procFile, int procsPerNode, 
                char allocPattern, int useBarrier)
{
  printf("\nTest Parameters\n");
  printf("---------------\n");
  printf("Operations per measurement : %8d\n", iters);

  if ( procFile )
    printf("Process count file : %s\n", procFile);

  if (procsPerNode > 0 )
    printf("Processes per SMP          : %8d\n", procsPerNode);

  if ( allocPattern == 'b' )
    printf("Process pair allocation    : %8s\n", "block");
  else
    printf("Process pair allocation    : %8s\n", "cyclic");

  if ( ! useBarrier )
    printf("\nBarrier not included in measurement.\n");
  
  printf("\n");
}
