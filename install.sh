#!/bin/bash

set -e
REPODIR=$(cd $(dirname $0); pwd)

source config_vars.sh

echo -e $MAG
echo '--------Compiling and installing dependencies and Isaac in ' $MY_INSTALLATION_PATH
read -p "--------Press <enter> to continue"
echo -e $NC

mkdir -p $MY_INSTALLATION_PATH

#cd isaac_installation/olcf-$SYSTEM/
#chmod +x isaacInstallation.sh
#./isaacInstallation.sh
cd $REPODIR

echo -e $MAG
echo '--------Done!'
echo

echo '--------Installing PIConGPU in ' $MY_INSTALLATION_PATH
read -p "---------Press <enter> to continue"
#cp -r $REPODIR/sources/$SYSTEM/picongpu $MY_INSTALLATION_PATH/picongpu
git clone -b $PICONGPU_BRANCH https://github.com/ComputationalRadiationPhysics/picongpu.git $MY_INSTALLATION_PATH/picongpu
echo '-------- increasing the GCDs reserved memory in  memory.param to 2GB'
sed -i 's@750[[:space:]][*][[:space:]]1024[[:space:]][*][[:space:]]1024@uint64_t(2147483648)@g' $MY_INSTALLATION_PATH/picongpu/share/picongpu/benchmarks/TWEAC-FOM/include/picongpu/param/memory.param
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
# $1 EXPERIMENT_NAME
# $2 MY_SIMULATION_NAME
compile_benchmark ()
{
    echo -e $MAG
    echo '--------Compiling Simulation ' $MY_SIMULATION_NAME
    echo '--------Simulation is in ' $MY_SIMULATIONS_PATH/$MY_SIMULATION_NAME
    read -p "--------Press <enter> to continue"
    echo -e $NC

    cd $MY_SIMULATIONS_PATH
    pic-create $PICSRC/share/picongpu/benchmarks/$EXPERIMENT_NAME $MY_SIMULATION_NAME
    cd $MY_SIMULATION_NAME
    pic-build
}

compile_benchmark $EXPERIMENT_NAME $MY_SIMULATION_NAME

