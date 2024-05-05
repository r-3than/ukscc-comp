#!/bin/bash
#SBATCH --job-name=hpl-big
#SBATCH --nodes=4

source /usr/share/Modules/init/bash
module load libraries/openmpi/5.0.3/armclang-24.04 compilers/armclang/24.04 libraries/armpl/24.04.0_gcc
mpirun ./xhpl
