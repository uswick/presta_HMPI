#
#  MPI Bandwidth and Latency Benchmark Makefile
#
#  Modify the CC, LIBS, CFLAGS, LDFLAGS, LIBDIR, and INCDIR values,
#    if necessary, to compile the test applications for the target system
#

CC=mpicc
LIBS= 
CFLAGS= -xhost
LDFLAGS=
INCDIR=/home1/02636/uswickra/Sync/HMPI/hmpi-svn

RMA  = rma
MSG  = com laten allred globalop
EXES = $(MSG) $(RMA)


def: $(EXES)

msg: $(MSG)

.c.o:
	$(CC) $(CFLAGS) $(INCDIR) -I$(INCDIR) $(LIBS) lib-mic/libhmpiMIC.a -c $<

com: com.c util.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o com.cpu com.c util.o -I$(INCDIR) $(LIBS) lib/libhmpi.a

rma: rma.c util.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ rma.c util.o $(LIBS)

laten: laten.c util.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o laten.cpu laten.c util.o -I$(INCDIR) $(LIBS) lib/libhmpi.a

allred: allred.c util.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ allred.c util.o -lm $(LIBS)

globalop: globalop.c 
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ globalop.c -lm $(LIBS)

clean:
	rm -f $(EXES) *.o
