#!/bin/bash

set -e
REPODIR=$(cd $(dirname $0); pwd)

source config_vars.sh

echo -e $MAG
echo '--------Compiling and installing dependencies and Isaac in ' $MY_INSTALLATION_PATH
read -p "--------Press <enter> to continue"
echo -e $NC

cd isaac_installation/olcf-$SYSTEM/
chmod +x isaacInstallation.sh
./isaacInstallation.sh
cd $REPODIR

echo -e $MAG
echo '--------Done!'
echo
echo '--------Installing PIConGPU in ' $MY_INSTALLATION_PATH
cp -r $REPODIR/sources/$SYSTEM/picongpu $MY_INSTALLATION_PATH
echo '--------Done!'
echo
echo '--------Loading PIConGPU environment'
echo -e $NC
cd picongpu_profiles
source picongpu.$SYSTEM.profile
cd $REPODIR

echo -e $MAG
echo '--------Done!'
echo -e $NC

mkdir -p $MY_SIMULATIONS_PATH
mkdir -p $MY_ISAAC_LOG_PATH

# Arguments
# $1 KH_SIM
# $2 MY_SIMULATION_NAME
compile_simulation ()
{
    echo -e $MAG
    echo '--------Compiling Simulation ' $MY_SIMULATION_NAME
    echo '--------Simulation is in ' $MY_SIMULATIONS_PATH/$MY_SIMULATION_NAME
    read -p "--------Press <enter> to continue"
    echo -e $NC
	
    cp -r $REPODIR/experiments/KelvinHelmholtz/simulation/$SYSTEM/$KH_SIM $PICSRC/share/picongpu/examples
    cd $MY_SIMULATIONS_PATH
    pic-create $PICSRC/share/picongpu/examples/$KH_SIM $MY_SIMULATION_NAME
    cd $MY_SIMULATION_NAME
    pic-build
}

KH_SIM=KelvinHelmholtz
compile_simulation $KH_SIM $MY_SIMULATION_NAME

#For crusher with need domain size 512x512x512:
if [ "$SYSTEM" == "crusher" ]; then
    # Sim. domain 512x512x512
    KH_SIM=KelvinHelmholtz_large
    MY_SIMULATION_NAME=${MY_SIMULATION_NAME}_large

    echo -e $MAG
    echo 'Note a second simulation of 512x512x512 will be compiled.'
    echo -e $NC
    
    compile_simulation $KH_SIM $MY_SIMULATION_NAME
fi

