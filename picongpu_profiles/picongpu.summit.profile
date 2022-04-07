#!/bin/bash
#
# Name and Path of this Script ############################### (DO NOT change!)
export PIC_PROFILE=$(cd $(dirname $BASH_SOURCE) && pwd)"/"$(basename $BASH_SOURCE)

# User Information ################################# (edit the following lines)
#   - automatically add your name and contact to output file meta data
#   - send me a mail on job (-B)egin, Fi(-N)ish
export MY_MAILNOTIFY="-B"
export MY_MAIL=$MAIL
export MY_NAME="$(whoami) <$MY_MAIL>"

# Project Information ######################################## (edit this line)
#   - project account for computing time
export proj=${PROJ_ID:-STF011}


# Text Editor for Tools ###################################### (edit this line)
#   - examples: "nano", "vim", "emacs -nw", "vi" or without terminal: "gedit"
#module load nano
export EDITOR="vim"

# basic environment ###########################################################
module load gcc/9.3.0
module load spectrum-mpi/10.4.0.3-20210112

export CC=$(which gcc)
export CXX=$(which g++)

# required tools and libs
module load git/2.31.1
module load cmake/3.21.3
module load cuda/11.0.3
#module load cuda/11.4.2
module load boost/1.74.0
#module load boost/1.76.0-cxx17

# plugins (optional) ##########################################################
#module load hdf5/1.10.3
#module load adios/1.13.1-py2 c-blosc zfp sz lz4
#module load ums
#module load ums-aph114
#module load openpmd-api/0.12.0

# optionally download libSplash and compile it yourself from
#   https://github.com/ComputationalRadiationPhysics/libSplash/
# export Splash_ROOT=<your libSplash install directory>  # e.g., ${HOME}/sw/libSplash-1.7.0
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$Splash_ROOT/lib
#export T3PIO_ROOT=$PROJWORK/$proj/lib/t3pio
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$T3PIO_ROOT/lib

#module load zlib/1.2.11
#module load libpng/1.6.34 freetype/2.9.1
module load libjpeg-turbo/2.1.0
module load libpng/1.6.37

# optionally install pngwriter yourself:
#   https://github.com/pngwriter/pngwriter#install
# export PNGwriter_ROOT=<your pngwriter install directory>  # e.g., ${HOME}/sw/pngwriter
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PNGwriter_ROOT/lib

# helper variables and tools ##################################################

#Should be the same where ISAAC lives
#export MY_HOME=$PROJWORK/csc434/benjha/src/summit/picongpu_3e6b54e_gcc
export MY_HOME=$MY_INSTALLATION_PATH

export PICSRC=$MY_HOME/picongpu
export PIC_EXAMPLES=$PICSRC/share/picongpu/examples
export PIC_BACKEND="cuda:70"

export PATH=$PATH:$PICSRC
export PATH=$PATH:$PICSRC/bin
export PATH=$PATH:$PICSRC/src/tools/bin

export PYTHONPATH=$PICSRC/lib/python:$PYTHONPATH

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

# fix MPI collectives by disabling IBM's optimized barriers
# https://github.com/ComputationalRadiationPhysics/picongpu/issues/3814
# looks like it is only required for I/O
#export OMPI_MCA_coll_ibm_skip_barrier=true

alias getNode="bsub -P $proj -W 2:00 -nnodes 1 -Is /bin/bash"

# "tbg" default options #######################################################
export TBG_SUBMIT="bsub"
export TBG_TPLFILE="etc/picongpu/summit-ornl/gpu_batch.tpl"

# Load autocompletion for PIConGPU commands
BASH_COMP_FILE=$PICSRC/bin/picongpu-completion.bash
if [ -f $BASH_COMP_FILE ] ; then
    source $BASH_COMP_FILE
else
    echo "bash completion file '$BASH_COMP_FILE' not found." >&2
fi
