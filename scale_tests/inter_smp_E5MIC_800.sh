#!/bin/bash
#----------------------------------------------------
# Example SLURM job script to run symmetric
# applications, (Host + MIC) or (MIC only) on TACC's
# Stampede system.
#----------------------------------------------------
#SBATCH -J symmetric_job_inter_smp_800_E5MIC    # Job name
#SBATCH -o symmetric_job_inter_smp_800_E5MIC_%j.log # Name of stdout output file(%j expands to jobId)
#SBATCH -e error_symmetric_job_inter_smp_800_E5MIC.o%j # Name of stderr output file(%j expands to jobId)
#SBATCH -p normal-mic #development       # Submit to the 'normal' or 'development' queue
#SBATCH -N 40              # Total number of nodes requested (16 cores/node)
#SBATCH -n 160               # Total number of mpi tasks requested
#SBATCH -t 10:20:00          # Run time (hh:mm:ss) - 1.5 hours
# The next line is required if the user has more than one project
# #SBATCH -A A-yourproject   # Allocation name to charge job against

# The number of host tasks is controlled by SLURM
# In this example it is 16.


TOTAL=20
TITLE="INTER SMP 800 ranks (E5/MIC) - 40 nodes (640 mic 160  e5) (16/mic && 4/e5)"
H_BIN="\"com.cpu -o 50\""
H_BIN2="\"laten.cpu -o 50\""
MIC_BIN="\"com.mic -o 50\""
MIC_BIN2="\"laten.mic -o 50\""


# Set the number of MPI TASKS per MIC(Default=4)
export MIC_PPN=16

# Set the number of host threads per task(Default=1)
export OMP_NUM_THREADS=2

# Set the number of mic threads per task(Default=30)
export MIC_OMP_NUM_THREADS=480

# This will start 16 host MPI tasks spread across 2 nodes and
# 2 MPI tasks on 2 MIC cards resulting in 20 total MPI tasks.
# Each host MPI task will use 2 threads/task and each MIC MPI task
# will use 480_E5MIC threads/task.

# The tasks will be allocated in consecutive order on the nodes
# NODE1:  8 host tasks ( 0 - 7) :  2 MIC tasks ( 8 - 9)
# NODE2:  8 host tasks (10 -17) :  2 MIC tasks (18 -19)

# Launch the symmetric application using ibrun.symm
#ibrun.symm -c testmpi.out.cpu -m testmpi.out.mic
#ibrun.symm -c testhmpi.out.cpu -m testhmpi.out.mic
#ibrun.symm -c "./com.cpu -o 50" -m "./com20.mic -o 50"

CMD="ibrun.symm -c $H_BIN -m $MIC_BIN"
#echo $CMD

RUN=1
echo "Experiment Title : $TITLE"
echo "No of Total Runs : $TOTAL"
echo "MIC procs per node : $MIC_PPN  OMP_NUM_THREADS: $OMP_NUM_THREADS  MIC_OMP_NUM_THREADS : $MIC_OMP_NUM_THREADS"
echo ""


echo "***************************************************"
echo "Experiment 1"
echo "***************************************************"
echo ""
echo ""
echo ""

while [ $RUN -le $TOTAL ]
do
   echo "****************  task $RUN Starting ****************"
   #ibrun.symm -c $H_BIN -m $MIC_BIN
   eval $CMD
#   ibrun.symm -c "a.out uswick" -m "a.out.mic udayanga"
   wait
   echo "************************* done ********************"
   echo "***************************************************"
   echo ""
   echo ""
   RUN=`expr $RUN + 1`
done


echo "***************************************************"
echo "Experiment 2"
echo "***************************************************"
echo ""
echo ""
echo ""


#CMD="ibrun.symm -m $MIC_BIN2"
CMD="ibrun.symm -c $H_BIN2 -m $MIC_BIN2"
RUN=0

while [ $RUN -le $TOTAL ]
do
   echo "****************  task $RUN Starting ****************"
   #ibrun.symm -c $H_BIN -m $MIC_BIN
   eval $CMD
#   ibrun.symm -c "a.out uswick" -m "a.out.mic udayanga"
   wait
   echo "************************* done ********************"
   echo "***************************************************"
   echo ""
   echo ""
   RUN=`expr $RUN + 1`
done
