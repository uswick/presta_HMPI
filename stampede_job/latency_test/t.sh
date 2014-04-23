#!/bin/bash
#----------------------------------------------------
# Example SLURM job script to run symmetric
# applications, (Host + MIC) or (MIC only) on TACC's
# Stampede system.
#----------------------------------------------------
#SBATCH -J symmetric_job     # Job name
#SBATCH -o %j_intraSMP_60.log # Name of stdout output file(%j expands to jobId)
#SBATCH -e symmetric_job.o%j # Name of stderr output file(%j expands to jobId)
#SBATCH -p development       # Submit to the 'normal' or 'development' queue
#SBATCH -N 1                # Total number of nodes requested (16 cores/node)
#SBATCH -n 16               # Total number of mpi tasks requested
#SBATCH -t 00:05:00          # Run time (hh:mm:ss) - 1.5 hours
# The next line is required if the user has more than one project
# #SBATCH -A A-yourproject   # Allocation name to charge job against

# The number of host tasks is controlled by SLURM
# In this example it is 16.

# Set the number of MPI TASKS per MIC(Default=4)
export MIC_PPN=4
#export MIC_PPN=2

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
#ibrun.symm -c "./com.cpu -o 10" -m "./com.mic -o 10"
#ibrun.symm -c "./laten.cpu -o 10" -m "./laten20.mic -o 10"
#ibrun.symm -c "./com.cpu -o 10" -m "./com20.mic -o 10"
#ibrun.symm -m "./com20.mic -o 50"
ibrun.symm -m "./com.mic -o 50"
