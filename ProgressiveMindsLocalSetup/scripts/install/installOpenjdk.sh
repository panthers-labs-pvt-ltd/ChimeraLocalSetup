#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

java_version=$(getVersionToInstall "java")


installed=false

if [[ $(which java | wc -l) > 0 ]]; then
  version_string=$( java --version | grep "openjdk" )
  if [[ $version_string == *"${java_version}."* ]]; then
    echo "java ${java_version} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then
    sudo apt install -y openjdk-${java_version}-jdk
    
    copyFromScriptConfigLocalToHomeLocalBinEnv "configureJvmEnv.sh"
    modifyBashrc "configureJvmEnv.sh" ". ${HOMEDIR}/.local/bin/env/configureJvmEnv.sh"
fi