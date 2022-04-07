#!/bin/bash
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
module load gcc/9.3.0
module load spectrum-mpi/10.4.0.3-20210112

export CC=$(which gcc)
export CXX=$(which g++)

# required tools and libs
module load git/2.31.1
module load cmake/3.21.3
module load cuda/11.0.3
module load boost/1.74.0

#should be the same where PIConGPU lives
#export MY_HOME=$PROJWORK/csc434/benjha/src/summit/picongpu_3e6b54e_gcc
# MY_INSTALLATION_PATH is declared in super script installer
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
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GLM_DIR/lib

export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$Jansson_DIR/lib
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$IceT_DIR/lib
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$Libwebsockets_DIR/lib
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$ISAAC_DIR/lib
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$GLM_DIR/lib


INSTALL_GLM=true
INSTALL_IceT=true
INSTALL_Jansson=true
INSTALL_Libwebsockets=true
INSTALL_JPEG=false

