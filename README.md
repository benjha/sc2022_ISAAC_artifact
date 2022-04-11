
# SC'2022 Artifact Description

We include three scripts to deploy the experiments in Summit and Crusher systems:

1. [`config_vars.sh`](https://github.com/benjha/sc2022_ISAAC_artifact/blob/main/config_vars.sh). This script includes the configuration variables that should be set by the user to install, configure and submit the experiments to the batch system. This script is modifiable by the user and is used by the `install.sh` and `run_experimen.sh` scripts.
2. `install.sh`. This script compiles and installs ISAAC, and the Kelvin-Helmholtz instability simulation. This script is only runnable by the user and should not be modified. 
3. `run_experiment.sh`. This script submits to the batch system the experiments described previously. This script is only runnable by the user and should not be modified. 

