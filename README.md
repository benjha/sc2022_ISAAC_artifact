
# SC'2022 Artifact Description

We reported the results of six experiments to evaluate the performance characteristics and portability of our in situ visualization solution. Three were run on Summit (`64_gpus`, `strong_scaling`, `weak_scaling`) and the other three on Crusher (`first_experiment`, `second_experiment`, `weak_scaling`). General simulations parameters:

* Kelvin-Helmholtz instability simulation.
* 256x256x256 cells per GPU, additionally on Crusher: 512x512x512 cells per GPU.
* Four particles per cell resulting in 134,217,728 macroparticles per GPU.
* Volume, isosurface, particles and vector field visualization  of three data sources. The threshold for isosurface visualization is set to the maximum of 1 for all sources to prevent any kind of early ray termination due to a valid isosurface.
* Trilinear Interpolation is enabled, and the step size is set to the default of 0.5.
* Halo exchange enabled.
* Timings are averaged from 1440 time steps. Starting simulation time step is 10 to allow stabilization. 
* Camera view's animation is divided into four stages, each with 360 steps and a rotation around a different axis to cover most of the viewing angles. 
* ISAAC streaming capabilities are disabled including image compression.

The interested reader can check the PIConGPU’s documentation under this [link](https://picongpu.readthedocs.io) for details on how to set up a simulation and a experiment. The configuration files used for the experiments are available following the next links:

1. Summit
    * 256x256x256 [Simulation](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/simulation/summit/KelvinHelmholtz)
    * Experiment: [64_gpus](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/summit/64_gpus)
    * Experiment: [strong_scaling](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/summit/strong_scaling)
    * Experiment: [weak_scaling](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/summit/weak_scaling)
2. Crusher
    * 256x256x256 [Simulation](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/simulation/crusher/KelvinHelmholtz)
    * 512x512x512 [Simulation](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/simulation/crusher/KelvinHelmholtz_large)
    * Experiment: [first_experiment](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/crusher/first_experiment)
    * Experiment: [second_experiment](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/crusher/second_experiment)
    * Experiment: [weak_scaling](https://github.com/benjha/sc2022_ISAAC_artifact/tree/main/experiments/KelvinHelmholtz/crusher/weak_scaling)


Experiments are reproduced following the instructions of the next section.

# Installation & Running Experiments

We include three scripts to deploy the experiments in Summit and Crusher systems:

1. [`config_vars.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/main/config_vars.sh). This script includes the configuration variables that should be set by the user to install, configure and submit the experiments to the batch system. This script is modifiable by the user and is used by the `install.sh` and `run_experimen.sh` scripts.
2. [`install.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/main/install.sh). This script compiles and installs ISAAC, and the Kelvin-Helmholtz instability simulation. This script is only runnable by the user and should not be modified. 
3. [`run_experiment.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/main/run_experiment.sh). This script submits to the batch system the experiments described previously. This script is only runnable by the user and should not be modified. 

The configuration variables defined in `config_vars.sh` are described next:

* `MAIL`. Specifies what e-mail will receive a notification when a submitted experiment is running. This variable is optional.
* `PROJ_ID`. Specifies what project id to use to submit a job. This variable is mandatory.
* `MY_INSTALLATION_PATH`. Indicates the installation path of all software stack. Make sure `MY_INSTALLATION_PATH` is under `$PROJWORK/<proj_id>/<user_id>`. This variable is mandatory.
* `MY_ISAAC_LOG_PATH`. Specifies the path of the performance files generated when running the code. Make sure `MY_ISAAC_LOG_PATH` is under `MY_INSTALLATION_PATH`. This variable is mandatory.
* `MY_SIMULATIONS_PATH`. Sets the simulations' path. Make sure it is under `MY_INSTALLATION_PATH`. This variable is mandatory.
* `MY_SIMULATION_NAME`. Indicates the name of the simulation. This variable is mandatory.
* `SYSTEM`. Specifies the target cluster to install and execute the experiments. Available options are: `summit`, `crusher`. This variable is mandatory
* `EXPERIMENT_NAME`. Sets the experiment name that will be submitted to the batch system.
    - Options for summit are: `64_gpus`, `strong_scaling`, `weak_scaling`.
    - Options for crusher are: `first_experiment`, `second_experiment`, `weak_scaling`. This variable is mandatory.
* `FRAMEBUFFER`. Sets the framebuffer resolution. This option is only used on `SYSTEM=summit` and `EXPERIMENT_NAME=64_gpus`.
    - Available options: 720 , 1080 , 1440 , 2160.
* `N_GPUS`. Sets the number of GPUs for strong scaling and weak scaling experiments.
    - Options for `SYSTEM=summit` and `EXPERIMENT_NAME=strong_scaling`: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512.
    - Options for `SYSTEM=summit` and `EXPERIMENT_NAME=weak_scaling`: 1, 8, 64, 512, 1000, 2755, 4096, 5832, 8000, 10648, 13824.
    - Options for `SYSTEM=crusher` and `EXPERIMENT_NAME=weak_scaling`: 1 , 8 , 64 , 216 , 512 , 1000.

## Installation

Installation steps are as follows:

1. Login to Summit or Crusher.
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
5. Set the next variables according to your preferences in config_vars.sh script:
`MAIL`, `PROJ_ID`, `MY_INSTALLATION_PATH`, `MY_ISAAC_LOG_PATH`, `MY_SIMULATIONS_PATH`, `MY_SIMULATION_NAME`,`SYSTEM`.

For example: 
```
export MAIL="mymail@myserver.com"
export PROJ_ID=ABC123
export MY_INSTALLATION_PATH=$PROJWORK/ABC123/myuserid/sc2022_AD/summit
export MY_ISAAC_LOG_PATH=$MY_INSTALLATION_PATH/isaac_logs
export MY_SIMULATIONS_PATH=$MY_INSTALLATION_PATH/simulations
export MY_SIMULATION_NAME=kh_isaac_test
export SYSTEM=summit
```
Note this example installs the software stack on Summit.

6. Execute the installation script only once per system:
```
./install.sh
```
## Running an experiment

For example, to run the weak_scaling experiment on Summit with 512 GPUs based on the previous section, follow the next steps:

1. Set the next variables in config_vars.sh script:
```
export EXPERIMENT_NAME=weak_scaling
export N_GPUS=512
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
export SYSTEM=summit
export EXPERIMENT_NAME=weak_scaling
export N_GPUS=512
```
For completeness, a `config_vars.sh` script example that is used to install the software stack and run the Crusher's `second_experiment` is shown next:
```
export MAIL="mymail@myserver.com"
export PROJ_ID=ABC123
export MY_INSTALLATION_PATH=$PROJWORK/ABC123/myuserid/sc2022_AD/crusher
export MY_ISAAC_LOG_PATH=$MY_INSTALLATION_PATH/isaac_logs
export MY_SIMULATIONS_PATH=$MY_INSTALLATION_PATH/simulations
export MY_SIMULATION_NAME=kh_isaac_test
export SYSTEM=crusher
export EXPERIMENT_NAME=second_experiment
```
