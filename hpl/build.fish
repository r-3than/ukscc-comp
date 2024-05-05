#!/usr/bin/fish
module load libraries/openmpi/5.0.3/armclang-24.04 compilers/armclang/24.04 libraries/armpl/24.04.0_gcc
set -x LIBRARY_PATH $LIBRARY_PATH:/apps/modules/libraries/arm_performance_libraries/armpl_24.04_gcc/lib/
set -x LD_LIBRARY_PATH $LD_LIBRARY_PATH:/apps/modules/libraries/arm_performance_libraries/armpl_24.04_gcc/lib/
sed -i "s/Atlas Fortran BLAS/ARMPL/" configure
sed -i "s/\-lf77blas \-latlas/-armpl/" configure
./configure
make clean
make -j arch=aarch64_armpl CFLAGS="-O3 -march=native -mtune=native -fopenmp -fomit-frame-pointer -funroll-loops"
