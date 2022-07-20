#!/bin/bash

# end me a mail on job
export MAIL="myemail@myserver.com"

# project id
export PROJ_ID=CSC434_crusher

# installation path
export MY_INSTALLATION_PATH=$PROJWORK/csc434/benjha/PIConGPU_ISAAC/tmp

# path to timing log
export MY_ISAAC_LOG_PATH=$MY_INSTALLATION_PATH/isaac_logs

# path to simulations
export MY_SIMULATIONS_PATH=$MY_INSTALLATION_PATH/simulations

# simulation name
export MY_SIMULATION_NAME=tweac_isaac_test

# picongpu branch or commit
export PICONGPU_BRANCH=dev

# ISAAC branch or commit
export ISAAC_BRANCH=7f9e627bef96504da1a4bcd821846e197f861bab

# deployment system
# options: crusher, frontier
export SYSTEM=crusher

# Sets the simulation name
# Options are: TWEAC-FOM
export EXPERIMENT_NAME=TWEAC-FOM

# Sets the experiment configuration file
# Additional files in sc2022_ISAAC_artifact/experiments/TWEAC-FOM/weak_scaling
export CONFIG_FILE=16.cfg

# Sets image width for ISAAC renderings
export WIDTH=1920

# Sets image height for ISAAC renderings
export HEIGHT=1080

# text color, do not modify
MAG='\033[0;35m'
NC='\033[0m'


echo -e $MAG
echo '--------Configuration Variables'
echo
echo "MAIL="$MAIL
echo "PROJ_ID="$PROJ_ID
echo "MY_INSTALLATION_PATH="$MY_INSTALLATION_PATH
echo "MY_ISAAC_LOG_PATH="$MY_ISAAC_LOG_PATH
echo "MY_SIMULATIONS_PATH="$MY_SIMULATIONS_PATH
echo "MY_SIMULATION_NAME="$MY_SIMULATION_NAME
echo "PICONGPU_BRANCH="$PICONGPU_BRANCH
echo "ISAAC_BRANCH="$ISAAC_BRANCH
echo "SYSTEM="$SYSTEM
echo "EXPERIMENT_NAME="$EXPERIMENT_NAME
echo "CONFIG_FILE="$CONFIG_FILE
echo "WIDTH="$WIDTH
echo "HEIGHT="$HEIGHT
echo -e $NC
