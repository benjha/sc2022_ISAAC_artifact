
# PIConGPU and ISAAC deployment on Frontier

TWEAC Benchmark

Experiments are reproduced following the instructions of the next section.

# Installation & Running Experiments

We include three scripts to deploy the experiments in Crusher and Frontier systems:

1. [`config_vars.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/frontier-rocm-5.1.0/config_vars.sh). This script includes the configuration variables that should be set by the user to install, configure and submit the experiments to the batch system. This script is modifiable by the user and is used by the `install.sh` and `run_experimen.sh` scripts.
2. [`install.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/frontier-rocm-5.1.0/install.sh). This script compiles and installs ISAAC, and the TWEAC benchmark. This script is only runnable by the user and should not be modified. 
3. [`run_experiment.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/frontier-rocm-5.1.0/run_experiment.sh). This script submits to the batch system a TWEAC benchmark according to a .cfg file. This script is only runnable by the user and should not be modified. 

The configuration variables defined in `config_vars.sh` are described next:

* `MAIL`. Specifies what e-mail will receive a notification when a submitted experiment is running. This variable is optional.
* `PROJ_ID`. Specifies what project id to use to submit a job. This variable is mandatory.
* `MY_INSTALLATION_PATH`. Indicates the installation path of all software stack. Make sure `MY_INSTALLATION_PATH` is under `$PROJWORK/<proj_id>/<user_id>`. This variable is mandatory.
* `MY_ISAAC_LOG_PATH`. Specifies the path of the performance files generated when running the code. Make sure `MY_ISAAC_LOG_PATH` is under `MY_INSTALLATION_PATH`.
* `MY_SIMULATIONS_PATH`. Sets the simulations' path. Make sure it is under `MY_INSTALLATION_PATH`. This variable is mandatory.
* `MY_SIMULATION_NAME`. Indicates the name of the simulation. This variable is mandatory.
* `SYSTEM`. Specifies the target cluster to install and execute the experiments. Available options are: `crusher`. This variable is mandatory
* `EXPERIMENT_NAME`. Sets the experiment name that will be submitted to the batch system.
    - Options for summit are: `TWEAC-FOAM`, `strong_scaling`, `weak_scaling`.
* `CONFIG_FILE`. Sets the experiment configuration file.
    - Available options: 16.cfg
    - Full list of files: https://github.com/benjha/sc2022_ISAAC_artifact/tree/frontier-rocm-5.1.0/experiments/TWEAC-FOM/weak_scaling

## Installation

Installation steps are as follows:

1. Login to Crusher or Frontier.
2. Clone this repository:
```
git clone https://github.com/benjha/sc2022_ISAAC_artifact.git
```
3. Go to `sc2022_ISAAC_artifact` directory.
4. Set executable the permissions for `install.sh` and `run_experiment.sh` scripts:
```
chmod +x install.sh
chmod +x run_experiment.sh
```
5. Set the next variables according to your preferences in config_vars.sh script as described previously.

For example: 
```
export MAIL="mymail@myserver.com"
export PROJ_ID=ABC123
export MY_INSTALLATION_PATH=$PROJWORK/ABC123/myuserid/sc2022_AD/crusher
export MY_ISAAC_LOG_PATH=$MY_INSTALLATION_PATH/isaac_logs
export MY_SIMULATIONS_PATH=$MY_INSTALLATION_PATH/simulations
export MY_SIMULATION_NAME=tweac_isaac_test
export SYSTEM=crusher
```
Note this example installs the software stack on Crusher.

6. Execute the installation script only once per system:
```
./install.sh
```
## Running an experiment

For example, to run the tweac benchmark on Crusher with 16 GPUs based on the previous section, follow the next steps:

1. Set the next variables in config_vars.sh script:
```
export EXPERIMENT_NAME=TWEAC-FOM
export CONFIG_FILE=16.cfg
```
2. Run the run_experiment.sh script:
```
./run_experiment.s
```
The complete definition of variables in `config_vars.sh` script for the 512 GPU weak scaling experiment on Summit is:
```
export MAIL="mymail@myserver.com"
export PROJ_ID=ABC123
export MY_INSTALLATION_PATH=$PROJWORK/ABC123/myuserid/sc2022_AD/summit
export MY_ISAAC_LOG_PATH=$MY_INSTALLATION_PATH/isaac_logs
export MY_SIMULATIONS_PATH=$MY_INSTALLATION_PATH/simulations
export MY_SIMULATION_NAME=kh_isaac_test
export SYSTEM=crusher
export EXPERIMENT_NAME=TWEAC-FOM
export CONFIG_FILE=16.cfg
```

## Running the ISAAC server

ISAAC server should be run before a simulation starts. [`run_isaac_server.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/frontier-rocm-5.1.0/run_isaac_server.sh) script set-ups the enviroment and execute the ISAAC server.

1. Open a tunnel conection:

* `ssh $USERNAME@$LOGIN_NODE -L 2459:$ISAAC_SERVER:2459`

Example in Crusher. Note all the bechmarks where configured to use Crusher's login1 node:

* `ssh id@login1.crusher.ornl.gov -L 2459:login1:2459`

2. Go to the directory where the repo. was cloned and execute the `run_isaac_server.sh` script.


