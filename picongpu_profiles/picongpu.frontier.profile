#!/bin/bash
# Name and Path of this Script ############################### (DO NOT change!)
export PIC_PROFILE=$(cd $(dirname $BASH_SOURCE) && pwd)"/"$(basename $BASH_SOURCE)

# User Information ################################# (edit the following lines)
#   - automatically add your name and contact to output file meta data
#   - send me a mail on batch system jobs: NONE, BEGIN, END, FAIL, REQUEUE, ALL,
#     TIME_LIMIT, TIME_LIMIT_90, TIME_LIMIT_80 and/or TIME_LIMIT_50
export MY_MAILNOTIFY="BEGIN"
export MY_MAIL="hernandezarb@ornl.gov"
export MY_NAME="$(whoami) <$MY_MAIL>"


# Project Information ######################################## (edit this line)
#   - project for allocation and shared directories
export PROJID=CSC434_crusher

# Text Editor for Tools ###################################### (edit this line)
#   - examples: "nano", "vim", "emacs -nw", "vi" or without terminal: "gedit"
export EDITOR="vim"

# General modules #############################################################
#
# There are a lot of required modules already loaded when connecting
# such as mpi, libfabric and others.
# The following modules just add to these.

# Compiling with cray compiler wrapper CC
# Must be same as ISAAC
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

# Other Software ##############################################################
#
#module load c-blosc/1.21.0
#module load cray-python/3.8.5.1
#module load hdf5/1.10.7 # dependency of openpmd-api module (no other possible)
#module load adios2/2.7.1 # dependency of openpmd-api module
#module load openpmd-api/0.13.4
module load libjpeg-turbo/2.1.0
module load libpng/1.6.37

# Self-Build Software #########################################################
# Optional, not required.
#
# needs to be compiled by the user
# Check the install script at
# https://gist.github.com/steindev/a063a0a0ab61c5bed3352ef1f5e07962
#
# export PROJECT=/ccs/proj/$PROJID/PIConGPU

# export PIC_LIBS=$PROJECT/lib
# export ZLIB_ROOT=$PIC_LIBS/zlib-1.2.11
# export PNGwriter_ROOT=$PIC_LIBS/pngwriter-0.7.0

# export LD_LIBRARY_PATH=$ZLIB_ROOT/lib:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=$PNGwriter_ROOT/lib:$LD_LIBRARY_PATH

# export CMAKE_PREFIX_PATH=$ZLIB_ROOT:$CMAKE_PREFIX_PATH

# Environment #################################################################
#

#export MY_HOME=$PROJWORK/csc434/benjha/src/crusher/picongpu_639375ed_hipcc
export MY_HOME=$MY_INSTALLATION_PATH

export PICSRC=$MY_HOME/picongpu
export PIC_EXAMPLES=$PICSRC/share/picongpu/examples
export PIC_BACKEND="hip:gfx90a"

export PATH=$PATH:$PICSRC
export PATH=$PATH:$PICSRC/bin
export PATH=$PATH:$PICSRC/src/tools/bin

export PYTHONPATH=$PICSRC/lib/python:$PYTHONPATH

export HIP_PATH=$ROCM_PATH/hip # has to be set in order to be able to compile
export CMAKE_MODULE_PATH=$HIP_PATH/cmake:$CMAKE_MODULE_PATH
export HIPCC_COMPILE_FLAGS_APPEND="$HIPCC_COMPILE_FLAGS_APPEND -I${MPICH_DIR}/include"
export HIPCC_LINK_FLAGS_APPEND="$HIPCC_LINK_FLAGS_APPEND -L${MPICH_DIR}/lib -lmpi -L${CRAY_MPICH_ROOTDIR}/gtl/lib -lmpi_gtl_hsa"
export HIPFLAGS="--amdgpu-target=gfx90a $HIPFLAGS"

export ISAAC_LIBS="$MY_HOME/lib"
export ISAAC_DIR=$MY_HOME/isaac_sources/isaac

export IceT_DIR=$ISAAC_LIBS/icet-2.1.1
export Jansson_DIR=$ISAAC_LIBS/jansson-2.11
export Libwebsockets_DIR=$ISAAC_LIBS/libwebsockets-4.0
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


export glm_DIR=$MY_HOME/lib/glm/lib64/cmake/glm

# "tbg" default options #######################################################
#   - SLURM (sbatch)
#   - "caar" queue
export TBG_SUBMIT="sbatch"
export TBG_TPLFILE="etc/picongpu/crusher-ornl/batch.tpl"

# allocate an interactive shell for one hour
#   getNode 2  # allocates two interactive nodes (default: 1)
function getNode() {
    if [ -z "$1" ] ; then
        numNodes=1
    else
        numNodes=$1
    fi
    srun  --time=1:00:00 --nodes=$numNodes --ntasks-per-node=8 --cpus-per-task=8 --gpus-per-task=1 --gpu-bind=closest --mem-per-gpu=64000 -p batch -A $PROJID --pty bash
}

# allocate an interactive shell for one hour
#   getDevice 2  # allocates two interactive devices (default: 1)
function getDevice() {
    if [ -z "$1" ] ; then
        numGPUs=1
    else
        if [ "$1" -gt 8 ] ; then
            echo "The maximal number of devices per node is 8." 1>&2
            return 1
        else
            numGPUs=$1
        fi
    fi
    srun  --time=1:00:00 --nodes=1 --ntasks-per-node=$(($numGPUs)) --cpus-per-task=8 --gpus-per-task=1 --gpu-bind=closest --mem-per-gpu=64000 -p batch -A $PROJID --pty bash
}

# Load autocompletion for PIConGPU commands
BASH_COMP_FILE=$PICSRC/bin/picongpu-completion.bash
if [ -f $BASH_COMP_FILE ] ; then
    source $BASH_COMP_FILE
else
    echo "bash completion file '$BASH_COMP_FILE' not found." >&2
fi

