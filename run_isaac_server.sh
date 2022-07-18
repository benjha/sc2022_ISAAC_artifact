#!/bin/bash

set -e
REPODIR=$(cd $(dirname $0); pwd)

source config_vars.sh

cd picongpu_profiles
source picongpu.$SYSTEM.profile
$MY_INSTALLATION_PATH/lib/isaac/bin/isaac

