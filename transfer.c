#include "transfer.h"

void pipeline_transfer();
void init_affinity(int tid);
int count = 0 ;
int scount = 0 ;
int rcount = 0 ;
void do_strasnfer(pthrequest* req){

    volatile int* offsetptr = req->offsetptr ;
    int* s_sync = req->s_sync ;
    int* r_sync = req->r_sync ;
    pthread_t thread[MAX_T];
    req->tid = 0 ;
    int i = 0 ; 	
    ++scount ;
    for(i =0 ; i < MAX_T ; i++){
          pthread_create( &thread[i], NULL, pipeline_transfer, (void*) req);
    }
    //pipeline_transfer(req);
    /*for(i =0 ; i < MAX_T ; i++){
           pthread_join( thread[i], NULL);
    } */              
    //*(req->r_sync) = 2 ;
    //pipeline_transfer(req);
    while(!__sync_bool_compare_and_swap(s_sync, 1 ,0)){
	
    	//printf("s in loop ! s_sync:  %d r_sync: %d  iter : %d\n",*s_sync,*r_sync, scount);
     }
    //printf("s done ! s_sync:  %d r_sync: %d  iter : %d\n",*s_sync,*r_sync, ++scount);
    //sleep(2);
}

void do_rtrasnfer(pthrequest* req){
    pthread_t thread[MAX_T];
    volatile int* offsetptr = req->offsetptr ;
    int* s_sync = req->s_sync ;
    int* r_sync = req->r_sync ;

    int i = 0 ;
    /*for(i =0 ; i < MAX_T ; i++){
        pthread_create( &thread[i], NULL, pipeline_transfer, (void*) req);
    }*/
    //pipeline_transfer(req);
    //*(req->r_sync) = 2 ;
    /*for(i =0 ; i < MAX_T ; i++){
       pthread_join( thread[i], NULL);
    }*/
    
    while(!__sync_bool_compare_and_swap(r_sync, MAX_T ,0));
    //printf("Total tid :%d  count : %d Buffsize : %d offset : %d  \n",req->tid, count, req->bufsize, *(req->offsetptr));
    count = 0 ;
    req->tid = 0 ;
    *offsetptr = 0 ;
    *s_sync = 1 ;
    //printf("r done ! s_sync:  %d r_sync: %d  iter : %d\n",*s_sync,*r_sync, ++rcount);
    //sleep(2);
}

void pipeline_transfer(void* r){
    pthrequest* req = (pthrequest*) r ;
    //printf("START TID %d %ld \n",req->tid, pthread_self());
    int local_tid = __sync_fetch_and_add(&req->tid,1);
    init_affinity(local_tid);
    volatile int* offsetptr = req->offsetptr ;
    int bufsize = req->bufsize ;
    uintptr_t sbuf = req->sbuf ;
    uintptr_t rbuf = req->rbuf;
    int offset = 0;
     //printf("TID %d %ld %p \n", local_tid, pthread_self(), req);
    while(1) {
        offset = __sync_fetch_and_add((volatile int *) offsetptr, BLOCKSIZE);
        if ((int)offset >= bufsize) {break ;}
        int left = bufsize - (int)offset;
        memcpy((void*)(rbuf + (int)offset), (void*)(sbuf  + (int)offset),
               (left <  BLOCKSIZE ? left : BLOCKSIZE));
        //if(left <= BLOCKSIZE && left > 0) {last = 1 ; last_left = left;}
    }
    __sync_fetch_and_add(req->r_sync, 1);
    //if i am the last to do a data transfer perform the restting of flag
    //if(last) {*(req->r_sync) = 2 ; printf("I AM LAST !! tid: %d run : %d left : %d bufsize : %d \n", local_tid, scount, last_left, bufsize); };
}

void init_affinity(int tid){
    cpu_set_t mask;
    CPU_ZERO(&mask);
    CPU_SET(tid + 1, &mask);
    //CPU_SET(my_id + 1, &mask);
    pthread_setaffinity_np(pthread_self(),sizeof(cpu_set_t),&mask);

}
