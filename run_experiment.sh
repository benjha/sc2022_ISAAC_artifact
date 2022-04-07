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
echo '--------Preparing experiment: ' $EXPERIMENT_NAME

if [ "$SYSTEM" == "summit" ]; then
    SUBMIT_COMMAND=bsub
    TPL_FILE=gpu_batch.tpl
    if [ "$EXPERIMENT_NAME" == "64_gpus" ]; then
	echo -e $MAG
        echo '--------FRAMEBUFFER set to ' $FRAMEBUFFER
	echo '--------valid options are: 720, 1080, 1440, 2160'
	echo -e $NC
	CONFIG_FILE=kh_isaac_64gpu_ss_$FRAMEBUFFER.cfg
	MY_EXPERIMENT=${EXPERIMENT_NAME}_$FRAMEBUFFER
    fi
    if [ "$EXPERIMENT_NAME" == "strong_scaling" ]; then
	echo -e $MAG
	echo '--------N_GPUS set to ' $N_GPUS
	echo '--------valid options are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512'
	echo -e $NC
        CONFIG_FILE=kh_isaac_${N_GPUS}gpu_ss.cfg
	MY_EXPERIMENT=${EXPERIMENT_NAME}_${N_GPUS}gpu
    fi
    if [ "$EXPERIMENT_NAME" == "weak_scaling" ]; then
        echo -e $MAG
        echo '--------N_GPUS set to ' $N_GPUS
        echo '--------valid options are: 1, 8, 64, 512, 1000, 2755, 4096, 5832, 8000, 10648, 13824'
        echo -e $NC
        CONFIG_FILE=kh_isaac_${N_GPUS}gpu_ws.cfg
        MY_EXPERIMENT=${EXPERIMENT_NAME}_${N_GPUS}gpu	
    fi
elif [ "$SYSTEM" == "crusher" ]; then
    SUBMIT_COMMAND=sbatch
    TPL_FILE=batch.tpl
    if [ "$EXPERIMENT_NAME" == "first_experiment" ]; then
	    echo -e $MAG
	    echo '--------Note two simulations will run.'
	    echo '--------The first one with a spatial domain of 512x512x512.'
	    echo '--------The second one with a spatial domain of 256x256x256.'
	    echo -e $NC

	    CONFIG_FILE=kh_isaac_1gpu_256_256_256.cfg
	    CONFIG_FILE_512=kh_isaac_1gpu_512_512_512.cfg
	    MY_EXPERIMENT=${EXPERIMENT_NAME}_256_256_256
	    MY_EXPERIMENT_512=${EXPERIMENT_NAME}_512_512_512

	    submit_experiment $CONFIG_FILE_512 ${MY_SIMULATION_NAME}_large $MY_EXPERIMENT_512 $SUBMIT_COMMAND $TPL_FILE
    fi
    if [ "$EXPERIMENT_NAME" == "second_experiment" ]; then
            echo -e $MAG
            echo '--------Note two simulations will run.'
            echo '--------The first one with a spatial domain of 512x512x512.'
            echo '--------The second one with a spatial domain of 256x256x256.'
	    echo -e $NC

            CONFIG_FILE=kh_isaac_1gpu_256_256_256_8K.cfg
            CONFIG_FILE_512=kh_isaac_1gpu_512_512_512_8K.cfg
            MY_EXPERIMENT=${EXPERIMENT_NAME}_256_256_256
            MY_EXPERIMENT_512=${EXPERIMENT_NAME}_512_512_512

            submit_experiment $CONFIG_FILE_512 ${MY_SIMULATION_NAME}_large $MY_EXPERIMENT_512 $SUBMIT_COMMAND $TPL_FILE
    fi
    if [ "$EXPERIMENT_NAME" == "weak_scaling" ]; then
        echo -e $MAG
        echo '--------N_GPUS set to ' $N_GPUS
	echo '--------valid options are: 1, 8, 64, 216, 512, 1000'
	echo -e $NC
        CONFIG_FILE=kh_isaac_${N_GPUS}gpu_ws.cfg
        MY_EXPERIMENT=${EXPERIMENT_NAME}_${N_GPUS}gpu
	MY_SIMULATION_NAME=${MY_SIMULATION_NAME}_large
    fi    
fi

# Arguments
# $1 CONFIG_FILE
# $2 MY_SIMULATION_NAME
# $3 MY_EXPERIMENT
# $4 SUBMIT_COMMAND
# $5 TPL_FILE
submit_experiment $CONFIG_FILE $MY_SIMULATION_NAME $MY_EXPERIMENT $SUBMIT_COMMAND $TPL_FILE


# cd $MY_SIMULATIONS_PATH/$MY_SIMULATION_NAME
# cp $REPODIR/experiments/KelvinHelmholtz/$SYSTEM/$EXPERIMENT_NAME/$CONFIG_FILE etc/picongpu
# echo -e $MAG
# echo '--------Submitting, wait a few seconds '
# echo '--------Experiment is in ' $MY_SIMULATIONS_PATH/$MY_SIMULATION_NAME/$MY_EXPERIMENT
# echo '--------Performance metrics are in ' $MY_ISAAC_LOG_PATH
# echo -e $NC
# tbg -s $SUBMIT_COMMAND -c etc/picongpu/$CONFIG_FILE -t etc/picongpu/$SYSTEM-ornl/$TPL_FILE ${MY_EXPERIMENT}
# echo -e $MAG
# echo '--------Done!'
# echo -e $NC

