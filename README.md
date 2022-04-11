
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

