#!/bin/bash
#
# load modules
# source $HOME/picongpu.profile

# Project Information ######################################## (edit this line)
#   - project account for computing time
# export proj=<yourProject>

# Text Editor for Tools ###################################### (edit this line)
#   - examples: "nano", "vim", "emacs -nw", "vi" or without terminal: "gedit"
#module load nano
#export EDITOR="nano"

# basic environment ###########################################################

# Compiling with cray compiler wrapper CC
# Must be same as picongpu
module load PrgEnv-cray/8.3.3
module load craype-accel-amd-gfx90a
module load rocm/5.1.0

export MPICH_GPU_SUPPORT_ENABLED=1
module load cray-mpich/8.1.16

module load cmake/3.22.2
module load boost/1.78.0-cxx17

## set environment variables required for compiling and linking w/ hipcc
##   see (https://docs.olcf.ornl.gov/systems/crusher_quick_start_guide.html#compiling-with-hipcc)
export CC=$(which hipcc)
export CXX=$(which hipcc)
export CXXFLAGS="$CXXFLAGS -I${MPICH_DIR}/include"
export LDFLAGS="$LDFLAGS -L${MPICH_DIR}/lib -lmpi -L${CRAY_MPICH_ROOTDIR}/gtl/lib -lmpi_gtl_hsa"


# required tools and libs
module load libjpeg-turbo/2.1.0


#export MY_HOME=$PROJWORK/csc434/benjha/src/crusher/picongpu_639375ed_hipcc
export MY_HOME=$MY_INSTALLATION_PATH
export ISAAC_LIBS="$MY_HOME/lib"

export IceT_DIR=$ISAAC_LIBS/icet-2.1.1
export Jansson_DIR=$ISAAC_LIBS/jansson-2.11
export Libwebsockets_DIR=$ISAAC_LIBS/libwebsockets-4.0
export ISAAC_DIR=$ISAAC_LIBS/isaac
export GLM_DIR=$ISAAC_LIBS/glm

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$IceT_DIR/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$Jansson_DIR/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$Libwebsockets_DIR/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ISAAC_DIR/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GLM_DIR/lib64

export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$Jansson_DIR/lib
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$IceT_DIR/lib
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$Libwebsockets_DIR/lib
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$ISAAC_DIR/lib
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$GLM_DIR/lib64

#export CMAKE_MODULE_PATH=$HIP_PATH/cmake:$CMAKE_MODULE_PATH
#export HIPCC_COMPILE_FLAGS_APPEND="$HIPCC_COMPILE_FLAGS_APPEND -I${MPICH_DIR}/include"
#export HIPCC_LINK_FLAGS_APPEND="$HIPCC_LINK_FLAGS_APPEND -L${MPICH_DIR}/lib -lmpi -L${CRAY_MPICH_ROOTDIR}/gtl/lib -lmpi_gtl_hsa"
#export HIPFLAGS="--amdgpu-target=gfx90a $HIPFLAGS"


INSTALL_GLM=true
INSTALL_IceT=true
INSTALL_Jansson=true
INSTALL_Libwebsockets=true
INSTALL_JPEG=false
