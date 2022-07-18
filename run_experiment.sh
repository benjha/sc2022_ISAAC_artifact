#!/bin/bash

set -e
REPODIR=$(cd $(dirname $0); pwd)

# Arguments
# $1 CONFIG_FILE
# $2 MY_SIMULATION_NAME
# $3 MY_EXPERIMENT
# $4 SUBMIT_COMMAND
# $5 TPL_FILE
submit_experiment ()
{
    cd $MY_SIMULATIONS_PATH/$MY_SIMULATION_NAME
    cp $REPODIR/experiments/KelvinHelmholtz/$SYSTEM/$EXPERIMENT_NAME/$1 etc/picongpu

    echo -e $MAG
    echo '--------Submitting, wait a few seconds '
    echo '--------Experiment is in ' $MY_SIMULATIONS_PATH/$2/$3
    echo '--------Performance metrics are in ' $MY_ISAAC_LOG_PATH
    echo -e $NC
    
    tbg -s $4 -c etc/picongpu/$1 -t etc/picongpu/$SYSTEM-ornl/$5 $3

    echo -e $MAG
    echo '--------Done!'
    echo -e $NC
}


source config_vars.sh

echo -e $MAG
echo '--------Loading PIConGPU environment'
echo -e $NC

cd picongpu_profiles
source picongpu.$SYSTEM.profile
cd $REPODIR

echo -e $MAG
echo '--------Preparing experiment with configuration: ' $CONFIG_FILE

SUBMIT_COMMAND=sbatch
TPL_FILE=batch.tpl

cd $MY_SIMULATIONS_PATH/$MY_SIMULATION_NAME
cp $REPODIR/experiments/TWEAC-FOM/weak_scaling/$CONFIG_FILE etc/picongpu

echo -e $MAG
echo '--------Submitting, wait a few seconds '
echo '--------Experiment is in ' $MY_SIMULATIONS_PATH/$MY_SIMULATION_NAME/$CONFIG_FILE
#echo '--------Performance metrics are in ' $MY_ISAAC_LOG_PATH
echo -e $NC

tbg -s $SUBMIT_COMMAND -c etc/picongpu/$CONFIG_FILE -t etc/picongpu/$SYSTEM-ornl/$TPL_FILE $CONFIG_FILE

