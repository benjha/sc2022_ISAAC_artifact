#!/bin/bash

# end me a mail on job
export MAIL="hernandezarb@ornl.gov"

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

# deployment system
# options: summit, crusher
export SYSTEM=crusher

# Sets the simulation name
# Options are: TWEAC-FOM
export EXPERIMENT_NAME=TWEAC-FOM

# Sets the experiment configuration file
export CONFIG_FILE=16.cfg

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
echo "EXPERIMENT_NAME="$EXPERIMENT_NAME
echo "SYSTEM="$SYSTEM
echo -e $NC
