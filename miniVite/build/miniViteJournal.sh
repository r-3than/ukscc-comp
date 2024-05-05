#!/bin/bash
#SBATCH --nodes=4
#SBATCH --partition=cpu
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

module load libraries/openmpi/5.0.3/gcc-13

mpirun -np 64 ./miniVite -r 4 -t 0.00075 -b -f ./com-LiveJournal.bin
