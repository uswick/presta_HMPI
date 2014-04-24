#include "transfer.h"

void pipeline_transfer();


static double	a[1048576], b[1048576] ;

/*void do_strasnfer(pthrequest *req) {

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
*/

int main(){
MPI_Init(NULL,NULL);
int j = 0 ;
int N = 1048576;
int i = 0;

int k = 0;
#pragma omp parallel
#pragma omp atomic 
		k++;
printf ("Number of Threads counted = %i\n",k);

for (j=0 ; j<50 ; j++){

//printf("TID %d %ld %p \n", local_tid, pthread_self(), req);

#pragma omp parallel for
    for (i=0; i<N; i++) {
	    a[i] = 1.0;
	    b[i] = 2.0;
	}

////printf("Thread %d starting... N : %d \n",tid, N);
    double start, diff;
    start = MPI_Wtime();
#pragma omp parallel for
    for (i = 0; i < N; i++) {
        //*((double *) rbuf + i) = *((double *) sbuf + i);
        //rbuf[i] = sbuf[i];
        a[i]= b[i];
    }
    diff = MPI_Wtime() - start ;
    
    printf("ELAPSED : %11.6f N: %d \n",diff, N);
}
return 0 ;
}


/*
void init_affinity(int tid) {
    cpu_set_t mask;
    CPU_ZERO(&mask);
    CPU_SET(tid + 1, &mask);
    //CPU_SET(my_id + 1, &mask);
    pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &mask);

}*/
