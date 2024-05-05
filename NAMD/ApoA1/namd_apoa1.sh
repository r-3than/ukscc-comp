#!/bin/bash
#SBATCH --job-name="namd_apoa1"        # jobname
#SBATCH --output="namd_apoa1.out"      # output file name
#SBATCH --nodes=4                      # node count
#SBATCH --ntasks-per-node=16           # total number of tasks (cpu-cores) across all nodes
#SBATCH --cpus-per-task=1              # cpu-cores per task (>1 if multi-threaded tasks)

module load binutils/13.2.0 compilers/gcc/13 libraries/openmpi/5.0.3/gcc-13 libraries/fftw/gcc-13

export OMP_NUM_THdREADS=$SLURM_CPUS_PER_TASK
mpirun -np 64 namd3 apoa1.namd
