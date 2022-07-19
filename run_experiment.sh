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
#cp $REPODIR/experiments/TWEAC-FOM/weak_scaling/$CONFIG_FILE etc/picongpu

CONFIG_FILE_ISAAC=isaac_${CONFIG_FILE}
cp $MY_INSTALLATION_PATH/picongpu/share/picongpu/benchmarks/TWEAC-FOM/etc/picongpu/$CONFIG_FILE \
        etc/picongpu/$CONFIG_FILE_ISAAC

echo '--------Injecting ISAAC plugin configuration to ' $CONFIG_FILE
sed -i '28 i #################################\n##        ISAAC Section        ##\n#################################\n\nTBG_width='${WIDTH}'\nTBG_height='${HEIGHT}'\n\nTBG_isaac="--isaac.period 1 --isaac.name tweac_bench --isaac.url login1 --isaac.width !TBG_width --isaac.height !TBG_height --isaac.quality 90"' etc/picongpu/$CONFIG_FILE_ISAAC

sed -i 's@\!TBG_steps@\!TBG_steps !TBG_isaac@g' etc/picongpu/$CONFIG_FILE_ISAAC
echo '--------Done!'
echo
echo -e $NC
cat etc/picongpu/$CONFIG_FILE_ISAAC

echo -e $MAG
echo '--------Submitting, wait a few seconds '
echo '--------Experiment is in ' $MY_SIMULATIONS_PATH/$MY_SIMULATION_NAME/$CONFIG_FILE_ISAAC
#echo '--------Performance metrics are in ' $MY_ISAAC_LOG_PATH
echo -e $NC

tbg -s $SUBMIT_COMMAND -c etc/picongpu/$CONFIG_FILE_ISAAC -t etc/picongpu/$SYSTEM-ornl/$TPL_FILE $CONFIG_FILE_ISAAC

