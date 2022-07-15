#!/bin/bash

# end me a mail on job
export MAIL="hernandezarb@ornl.gov"

# project id
export PROJ_ID=CSC434_crusher

# installation path
export MY_INSTALLATION_PATH=$PROJWORK/csc434/benjha/PIConGPU/tmp

# path to timing log
export MY_ISAAC_LOG_PATH=$MY_INSTALLATION_PATH/isaac_logs

# path to simulations
export MY_SIMULATIONS_PATH=$MY_INSTALLATION_PATH/simulations

# simulation name
export MY_SIMULATION_NAME=kh_isaac_test

# deployment system
# options: summit, crusher
export SYSTEM=crusher

# Set the experiment
# Options for Summit are: 64_gpus, strong_scaling, weak_scaling
# Options for Crusher are: first_experiment , second_experiment , weak_scaling
export EXPERIMENT_NAME=second_experiment

# Framebuffer resolution depends on the experiment
# On Summit set it for 64_gpus experiment
# Options for Summit's 64_gpus experiment: 720 , 1080 , 1440 , 2160
# This option will be omitted on Crusher
export FRAMEBUFFER=1080

# Number of GPUs, depends of the experiment
# On Summit set it for strong_scaling, weak_scaling experiments
# On Crusher set it for weak_scaling experiment
# Options for Summit's strong_scaling: 1 , 2 , 4 , 8 , 16 , 32 , 64 , 128 , 256 , 512
# Options for Summit's weak_scaling: 1 , 8 , 64 , 512 , 1000 , 2755 , 4096 , 5832 , 8000 , 10648 , 13824
# Options fot Cursher's weak_scaling: 1 , 8 , 64 , 216 , 512 , 1000
# This option will be ommitted for experiments 64_gpus , first_experiment , second_experiment
export N_GPUS=8

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
echo "FRAMEBUFFER"=$FRAMEBUFFER
echo "N_GPUS"=$N_GPUS
echo -e $NC
