#!/bin/bash
wget http://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-7.4.tar.gz
tar -xf osu-micro-benchmarks-7.4.tar.gz
mv osu-micro-benchmarks-7.4 osu
rm osu-micro-benchmarks-7.4.tar.gz


./configure CC=/apps/modules/libraries/openmpi/5.0.3/gcc-13/bin/mpicc CXX=/apps/modules/libraries/openmpi/5.0.3/gcc-13/bin/mpicxx CFLAGS="-O3 -g" CXXFLAGS="-O3 -g"
make
make install
