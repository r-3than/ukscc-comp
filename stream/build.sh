#!/bin/bash
module load compilers/gcc/13 libraries/openmpi/5.0.3/gcc-13
gcc -DSTREAM_ARRAY_SIZE=100000000 -fopenmp stream.c -funroll-loops -O3 -o stream
./stream
