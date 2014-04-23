#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <stdint.h>

#define NTHREADS 2
void* thread_function(void *);
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
int  counter = 0;

volatile int offset_ptr = 0 ;
volatile int sync = 0 ;
volatile int sync_complete = 0;
volatile int count = 0 ;

volatile int c1 = 0 ;
volatile int c2 = 0 ;
#ifndef BLOCKSIZE
#   define BLOCKSIZE 4096
#endif

main()
{
   pthread_t thread_id[NTHREADS];
   int i, j;
   int* tid = malloc(NTHREADS * sizeof(int));
   /*sync = malloc(sizeof(int));
   sync[0] = 0 ;
   sync_complete = malloc(sizeof(int));
   sync_complete[0] = 0 ;
   offset_ptr = malloc(sizeof(int));
   offset_ptr[0] = 0 ;
*/
   for(i=0; i < NTHREADS; i++)
   {
      tid[i] = i ;
      pthread_create( &thread_id[i], NULL, thread_function, (void*) &tid[i] );
   }

   for(j=0; j < NTHREADS; j++)
   {
      pthread_join( thread_id[j], NULL); 
   }
  
   /* Now that all threads are complete I can print the final result.     */
   /* Without the join I could be printing a value before all the threads */
   /* have been completed.                                                */

   printf("Final counter value: %d %d %d\n", count,c1, c2);
}

void* thread_function(void *dummyPtr)
{

   /*cpu_set_t mask;
   CPU_ZERO(&mask);
   //CPU_SET(my_id + 1 + my_id*4 , &mask);
   CPU_SET(my_id + 1, &mask);
   pthread_setaffinity_np(pthread_self(),sizeof(cpu_set_t),&mask);
*/
   int iters = 100 ;
   int* id = ((int *) dummyPtr);
   if(id[0]%2 == 0){
	//sender
	int i = 0 ;
	printf("my even id %d \n", id[0]);
	
	for ( i = 0; i < iters; i++ ){

		volatile int complete = 0;
		do {
		  if(__sync_bool_compare_and_swap(&sync_complete, 1 ,0)) complete = 1 ;
                  volatile size_t* offsetptr = &offset_ptr;
                  size_t offset;
                  //wait untill receiver signals
                  if(__sync_bool_compare_and_swap(&sync, 1 ,0)) {
                    //printf("ok send start buffer: %d %d \n",bufsize , req_array[currtarg].sync[0]);
                    //printf("ok send start %d \n",sync);
		    
                    //length to copy is min of len - offset and BLOCK_SIZE
                    while((offset = __sync_fetch_and_add((volatile size_t *)offsetptr, BLOCKSIZE)) < 8388608) {
                          size_t left = 8388608 - offset;
                          //do some work
			  int j = 0 ;
			  for(j=0 ; j< 100000 ;j++) ;
                          __sync_fetch_and_add(&count, 1);
                          //printf("ok send [2 transfer]  %d \n",sync);
			  c2++;
                          
                      }
                    //printf("ok send [2] start buffer: %d \n" , sync);
                   // __sync_synchronize();
                    //inidcate that sender done copying since reciever waits
                    sync = 2 ;
		    //__sync_synchronize();
                    //reciever will signal wait for reciever completes
                    while(!__sync_bool_compare_and_swap(&sync_complete, 1 ,0));
                    //printf("ok send [3] : %d \n",sync);
                    complete = 1;
                  	
			}
                   //printf("ok send [loop] complete : %d %d\n", complete, sync);
		    
                }while(!complete);
	}


   }else {
	printf("my odd id %d \n", id[0]);
	int i = 0 ;
	for ( i = 0; i < iters; i++ ){
		//int i = 0 ;	
		volatile size_t* offsetptr = &offset_ptr;
              	size_t offset = 0;

                //printf("ok recv start %d \n", sync);

              // reciever indicate sender to engage in synergistic protocol
               	__sync_fetch_and_sub(&offset_ptr, offset_ptr);
	        sync = 1 ;

		//sleep(5);
              //length to copy is min of len - offset and BLOCK_SIZE
              //length to copy is min of len - offset and BLOCK_SIZE
		 //printf("ok recv [2a wait]  %d  \n",offset);
		//printf("ok recv [2b wait]  %d  \n",offset);
                while((offset = __sync_fetch_and_add((volatile size_t *)offsetptr, BLOCKSIZE)) < 8388608) {
                          size_t left = 8388608 - offset;
                          //do some work
			  int j = 0 ;
			  for(j=0 ; j< 100000 ;j++) ;
                          __sync_fetch_and_add(&count, 1);
			  c1++;
                          //printf("ok recv [2 transfer]  %d \n",sync);
                    }
	        //printf("ok recv [2b wait]  %d  \n",offset);
		//sleep(1);			

              //printf("ok recv [2]  %d \n",sync);
              //now waits for sender until it is done copying
              while(!__sync_bool_compare_and_swap(&sync, 2 ,0)){/* printf("ok recv [3 wait]  %d \n",sync)*/; ;}
              //printf("ok recv [3]  %d \n",sync);

              //indicate completion of the transfer to the sender
	      //__sync_synchronize();
              sync_complete = 1 ;
	}
   }
}
