#!/bin/bash
#SBATCH --job-name=hpl-big-omp
#SBATCH --nodes=4

source /usr/share/Modules/init/bash
module load libraries/openmpi/5.0.3/armclang-24.04 compilers/armclang/24.04 libraries/armpl/24.04.0_gcc
mpirun -x OMP_NUM_THREADS=16 --map-by node:PE=16 ./xhpl
