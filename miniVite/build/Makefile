
CXX = g++

MPI_INCLUDE = /apps/modules/libraries/openmpi/4.1.6/gcc-13/include
MPI_LIB = /apps/modules/libraries/openmpi/4.1.6/gcc-13/lib


USE_TAUPROF=0
ifeq ($(USE_TAUPROF),1)
TAU=/soft/perftools/tau/tau-2.29/craycnl/lib
CXX = tau_cxx.sh -tau_makefile=$(TAU)/Makefile.tau-intel-papi-mpi-pdt 
endif
# use -xmic-avx512 instead of -xHost for Intel Xeon Phi platforms
OPTFLAGS = -O3 -march=native -msve-vector-bits=scalable -mcpu=native -mtune=native -fopenmp -DPRINT_DIST_STATS #-DPRINT_EXTRA_NEDGES #-DUSE_MPI_RMA -DUSE_MPI_ACCUMULATE #-DUSE_32_BIT_GRAPH #-DDEBUG_PRINTF #-DUSE_MPI_RMA #-DPRINT_LCG_DOUBLE_LOHI_RANDOM_NUMBERS#-DUSE_MPI_RMA #-DPRINT_LCG_DOUBLE_RANDOM_NUMBERS #-DPRINT_RANDOM_XY_COORD
#-DUSE_MPI_SENDRECV
#-DUSE_MPI_COLLECTIVES
# use export ASAN_OPTIONS=verbosity=1 to check ASAN output
SNTFLAGS = -std=c++11 -fopenmp -fsanitize=address -O1 -fno-omit-frame-pointer
CXXFLAGS = -std=c++11 -g $(OPTFLAGS) -I$(MPI_INCLUDE) -L$(MPI_LIB)

OBJ = main.o
TARGET = miniVite

all: $(TARGET)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $^ -lmpi

$(TARGET):  $(OBJ)
	$(CXX) $^ $(OPTFLAGS) -o $@ -lmpi

.PHONY: clean

clean:
	rm -rf *~ $(OBJ) $(TARGET)
