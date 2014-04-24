#ifndef _STREAM_PTHR_TR_H_
#define _STREAM_PTHR_TR_H_

#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <pthread.h>
#include <hmpi.h>

#define MAX_T 60
#ifndef BLOCKSIZE
#   define BLOCKSIZE 12288
//#   define BLOCKSIZE 12288
#endif

typedef struct pthrequest{
    uintptr_t sbuf ;
    uintptr_t rbuf ;
    int bufsize ;
    int* offsetptr ;
    int* s_sync ;
    int* r_sync;
    int tid;
}pthrequest ;

void do_strasnfer(pthrequest* send_r);
void do_rtrasnfer(pthrequest* recv_r);

#endif
