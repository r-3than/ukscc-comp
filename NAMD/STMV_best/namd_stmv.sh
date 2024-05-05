#!/bin/bash
#SBATCH --job-name="namd_stmv"
#SBATCH --output="namd_stmv.out"
#SBATCH --partition=cpu
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1

module load binutils/13.2.0 compilers/gcc/13 libraries/openmpi/5.0.3/gcc-13 libraries/fftw/gcc-13

mpirun -np 64 namd3 stmv.namd
