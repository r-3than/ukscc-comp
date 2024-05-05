#!/bin/bash

# get required modules
module load binutils/13.2.0 compilers/gcc/13 libraries/openmpi/5.0.3/gcc-13
wget https://cmake.org/files/v3.26/cmake-3.26.6-linux-aarch64.sh -O cmake.sh # requires a different version which has python
sh cmake.sh --prefix=/home/adaniels/ --exclude-subdir
rm cmake.sh

# get NAMD
wget https://www.ks.uiuc.edu/Research/namd/3.0b6/download/120834/NAMD_3.0b6_Source.tar.gz
tar xzf NAMD_3.0b6_Source.tar.gz
rm NAMD_3.0b6_Source.tar.gz
cd NAMD_3.0b6_Source/

#get depedencies - charm
tar xf charm-7.0.0.tar
rm charm-7.0.0.tar
cd charm-v7.0.0
env MPICXX=mpicxx ./build charm++ mpi-linux-arm8 -j8 --with-production
cd ../

#get dependencies - FFTW
wget https://www.ks.uiuc.edu/Research/namd/libraries/fftw-linux-arm64.tar.gz -O fftw.tar.gz
tar xzf fftw.tar.gz
rm fftw.tar.gz
mv fftw-linux-arm64 fftw

#get dependencies TCL
wget http://prdownloads.sourceforge.net/tcl/tcl8.5.9-src.tar.gz
tar xzf tcl8.5.9-src.tar.gz
rm tcl8.5.9-src.tar.gz
mv tcl8.5.9 tcl
cd tcl/unix
./configure --prefix=/home/adaniels/NAMD_3.0b6_Source/tcl/
make
make install
cd ../../
export PATH=/home/adaniels/NAMD_3.0b6_Source/tcl/lib:$PATH
export LD_LIBRARY_PATH=/home/adaniels/NAMD_3.0b6_Source/tcl/lib:$LD_LIBRARY_PATH

#set up NAMD build directory and make
./config Linux-ARM64-g++ --charm-arch mpi-linux-arm8
cd Linux-ARM64-g++
gmake -j8
