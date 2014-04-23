#include "transfer.h"

void pipeline_transfer();

void init_affinity(int tid);

int count = 0;
int scount = 0;
int rcount = 0;

void do_strasnfer(pthrequest *req) {

    volatile int *offsetptr = req->offsetptr;
    int *s_sync = req->s_sync;
    ++scount;
    pipeline_transfer(req);

    while (!__sync_bool_compare_and_swap(s_sync, 1, 0)) {
        //printf("s in loop ! s_sync:  %d r_sync: %d  iter : %d\n",*s_sync,*r_sync, scount);
    }
    //printf("s done ! s_sync:  %d r_sync: %d  iter : %d\n",*s_sync,*r_sync, ++scount);
}

void do_rtrasnfer(pthrequest *req) {
    pthread_t thread[MAX_T];
    volatile int *offsetptr = req->offsetptr;
    int *s_sync = req->s_sync;
    int *r_sync = req->r_sync;

    while (!__sync_bool_compare_and_swap(r_sync, 1, 0));
    //printf("Total tid :%d  count : %d Buffsize : %d offset : %d  \n",req->tid, count, req->bufsize, *(req->offsetptr));
    count = 0;
    *offsetptr = 0;
    *s_sync = 1;
    //printf("r done ! s_sync:  %d r_sync: %d  iter : %d\n",*s_sync,*r_sync, ++rcount);
    //sleep(2);
}

void pipeline_transfer(void *r) {
    pthrequest *req = (pthrequest *) r;
    int bufsize = req->bufsize;
    uintptr_t sbuf = req->sbuf;
    uintptr_t rbuf = req->rbuf;
    int N = bufsize / sizeof(double);
    if (bufsize % sizeof(double) != 0) N++;
    int i = 0;
//printf("TID %d %ld %p \n", local_tid, pthread_self(), req);

////printf("Thread %d starting... N : %d \n",tid, N);
    double start, diff;
    start = MPI_Wtime();
#pragma omp parallel for
    for (i = 0; i < N; i++) {
        *((double *) rbuf + i) = *((double *) sbuf + i);
    }
    diff = MPI_Wtime() - start ;
    printf("elapsed time : %12.3f buffSize: %d  N: %d \n",diff, bufsize, N);
    *(req->r_sync) = 1;
}


void init_affinity(int tid) {
    cpu_set_t mask;
    CPU_ZERO(&mask);
    CPU_SET(tid + 1, &mask);
    //CPU_SET(my_id + 1, &mask);
    pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &mask);

}
