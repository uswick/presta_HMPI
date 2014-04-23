#!/bin/bash
#----------------------------------------------------
# Example SLURM job script to run symmetric
# applications, (Host + MIC) or (MIC only) on TACC's
# Stampede system.
#----------------------------------------------------
#SBATCH -J symmetric_job     # Job name
#SBATCH -o symmetric_job_%j.log # Name of stdout output file(%j expands to jobId)
#SBATCH -e error_symmetric_job.o%j # Name of stderr output file(%j expands to jobId)
#SBATCH -p normal-mic #development       # Submit to the 'normal' or 'development' queue
#SBATCH -N 2                # Total number of nodes requested (16 cores/node)
#SBATCH -n 16                # Total number of mpi tasks requested
#SBATCH -t 00:20:00          # Run time (hh:mm:ss) - 1.5 hours
# The next line is required if the user has more than one project
# #SBATCH -A A-yourproject   # Allocation name to charge job against

# The number of host tasks is controlled by SLURM
# In this example it is 16.


TOTAL=3
TITLE="TEMPLATE RUN"
H_BIN="\"a.out  uswick\""
MIC_BIN="\"a.out.mic udayanga\""


# Set the number of MPI TASKS per MIC(Default=4)
export MIC_PPN=2

# Set the number of host threads per task(Default=1)
export OMP_NUM_THREADS=2

# Set the number of mic threads per task(Default=30)
export MIC_OMP_NUM_THREADS=60

# This will start 16 host MPI tasks spread across 2 nodes and
# 2 MPI tasks on 2 MIC cards resulting in 20 total MPI tasks.
# Each host MPI task will use 2 threads/task and each MIC MPI task
# will use 60 threads/task.

# The tasks will be allocated in consecutive order on the nodes
# NODE1:  8 host tasks ( 0 - 7) :  2 MIC tasks ( 8 - 9)
# NODE2:  8 host tasks (10 -17) :  2 MIC tasks (18 -19)

# Launch the symmetric application using ibrun.symm
#ibrun.symm -c testmpi.out.cpu -m testmpi.out.mic
#ibrun.symm -c testhmpi.out.cpu -m testhmpi.out.mic
#ibrun.symm -c "./com.cpu -o 50" -m "./com20.mic -o 50"

CMD="ibrun.symm -c $H_BIN -m $MIC_BIN"
echo $CMD
$CMD

#ibrun.symm -c "./a.out" -m "./a.out.mic"
#wait
#echo "task1 done"

#ibrun.symm -c "./a.out" -m "./a.out.mic"
#wait
#echo "task2 done"



