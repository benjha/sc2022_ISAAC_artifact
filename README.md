
# SC'2022 Artifact Description

We reported the results of six experiments to evaluate the performance characteristics and portability of our in situ visualization solution. Three were run on Summit and the other three on Crusher. General simulations parameters:

* Kelvin-Helmholtz instability simulation.
* 256x256x256 cells per GPU, additionally on Crusher: 512x512x512 cells per GPU.
* Four particles per cell resulting in 134,217,728 macroparticles per GPU.
* Volume, isosurface, particles and vector field visualization  of three data sources. The threshold for isosurface visualization is set to the maximum of 1 for all sources to prevent any kind of early ray termination due to a valid isosurface.
* Trilinear Interpolation is enabled, and the step size is set to the default of 0.5.
* Halo exchange enabled.
* Timings are averaged from 1440 time steps. Starting simulation time step is 10 to allow stabilization. 
* Camera view's animation is divided into four stages, each with 360 steps and a rotation around a different axis to cover most of the viewing angles. 
* ISAAC streaming capabilities are disabled including image compression.

We include three scripts to deploy the experiments in Summit and Crusher systems:

1. [`config_vars.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/main/config_vars.sh). This script includes the configuration variables that should be set by the user to install, configure and submit the experiments to the batch system. This script is modifiable by the user and is used by the `install.sh` and `run_experimen.sh` scripts.
2. [`install.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/main/install.sh). This script compiles and installs ISAAC, and the Kelvin-Helmholtz instability simulation. This script is only runnable by the user and should not be modified. 
3. [`run_experiment.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/main/run_experiment.sh). This script submits to the batch system the experiments described previously. This script is only runnable by the user and should not be modified. 

