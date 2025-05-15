#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

VERSION_RUST=$(getVersionToInstall "rust")

installed=false

if [[ $(which rustc | wc -l) > 0 ]]; then
  version_string=$( rustc --version | grep "rustc" )
  if [[ $version_string == *"${VERSION_RUST}"* ]]; then
    echo "rust ${VERSION_RUST} is already installed"
    installed=true
  fi
fi

# Think of upgrade later
if [ $installed = false ]; then

    # Modifications of bashrc is done only by modifyBashrc function, therefore files changed by installer are saved and restored
    cp ${HOMEDIR}/.bashrc ${HOMEDIR}/.bashrc.bak
    cp ${HOMEDIR}/.profile ${HOMEDIR}/.profile.bak

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o ${HOMEDIR}/Downloads/rustup
    bash ${HOMEDIR}/Downloads/rustup -y

    mv ${HOMEDIR}/.bashrc.bak ${HOMEDIR}/.bashrc
    mv ${HOMEDIR}/.profile.bak ${HOMEDIR}/.profile

    modifyBashrc ".cargo/env" ". ${HOMEDIR}/.cargo/env"
fi
