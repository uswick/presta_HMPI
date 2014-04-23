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

//HMPI request types
#define HMPI_SEND 1
#define HMPI_RECV 2
#define MPI_SEND 4
#define MPI_RECV 8

//ACTIVE and COMPLETE specifically chosen to match MPI test flags
#define HMPI_REQ_ACTIVE 0
#define HMPI_REQ_COMPLETE 1

//static char* outputFormat     = "  %-14s  %9d  %20d  %15.3f  %12.3f\n";
static char* outputFormat     = "  %-14s  %9d %9d  %20d  %15.3f  %12.3f\n";
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

HMPI_Request_info* req_array ;

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
   printf("in START  \n");
  //Set up intra-node shared memory structures.
  if(rank == 0) {
        //One rank per node allocates shared send request lists.
        req_array = malloc(wsize*sizeof(HMPI_Request_info));
        /*if(!IS_SM_BUF((void*)req_array)){
            printf("Failed to allocate from SM region :%p \n", req_array);
            exit(-1);
        }*/
  }
  //broadcast address of the pointer variable so that each rank has access to it
  MPI_Bcast(&req_array , 1, MPI_LONG, 0, MPI_COMM_WORLD);
  printf("Broadcasting of shared mem region complete! rank : %d  region_addr : %lu region_ptr : %lu \n", rank, &req_array, req_array);
  //printf("Access shm region ! rank : %d  region for sync : %lu  \n", rank, req_array[rank].sync);

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
  HMPI_Request_info* thisReq;
  double totalops;
  uintptr_t sbuf, rbuf ; 
  currtarg = getTargetRank(rank, wsize, procsPerNode, useNearestRank);

  diff     = 0;
  maxtime  = 0;

  int count = 0 ;
  if ( isActiveProc(rank, wsize, procsPerNode, procs, 
                    allocPattern, useNearestRank) )
  {
        comBuf  = (char*)malloc(bufsize);
        memset(comBuf, 0, bufsize);
        thisReq = (HMPI_Request_info *) acquire_req();
        thisReq->type = HMPI_RECV;
        thisReq->size = (size_t)bufsize ;
        thisReq->buf = comBuf;
        thisReq->stat = HMPI_REQ_ACTIVE; //Avoid fence in update_reqstat() on BGQ


        //allocate memory for sync flags both this rank and the target
        //we will keep senders sync flag --> to indicate done copying
        //we will keep recievers sync flag --> to indicate completion of transfer to start again

        req_array[currtarg] = *thisReq;



    //generic_barrier(*activeComm);
    //generic_barrier(*activeComm);
    MPI_Barrier(*activeComm);
    MPI_Barrier(*activeComm);
    iters = 1 ;
    if ( rank < currtarg )
    {
      /*  Sender - Time operation loop  */
      start = MPI_Wtime();
      for ( i = 0; i < iters; i++ )  {
                 do {
		    printf("in loop[] sender \n");
                    // do nothing here we dont wont to match
                 } while(HMPI_Progress_send(thisReq) != HMPI_REQ_COMPLETE);
		 printf("out loop[] sender \n");
                 thisReq->stat = HMPI_REQ_ACTIVE;

      }
    }
    else 
    {
      //Reciever code
      start = MPI_Wtime();
      for ( i = 0; i < iters; i++ )
      {
	      printf("in reciever start \n");
              HMPI_Complete_recv(thisReq, (HMPI_Request) &req_array[rank]);
	      printf("in reciever done \n");
		
      }
    }

    //printf("cpoint11 rank: %d \n", rank);
    if ( useBarrier )
      MPI_Barrier(*activeComm);
      //generic_barrier(*activeComm);

    diff = MPI_Wtime() - start;

    free(comBuf);
  }

  //printf("cpoint12 rank: %d \n", rank);
  MPI_Barrier(MPI_COMM_WORLD);

  /*  Get maximum sample length  */
  MPI_Reduce(&diff, &maxtime, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
  int count_sum = 0 ;
  MPI_Reduce(&count, &count_sum, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

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
      printf(outputFormat, "Unidirectional", procs, count_sum, bufsize, 
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
