#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_MINICONDA=$(getVersionToInstall "miniconda")

installed=false

if [[ $(which conda | wc -l) > 0 ]]; then
  version_string=$( conda --version | grep "conda" )
  if [[ $version_string == *"${VERSION_MINICONDA}"* ]]; then
    echo "miniconda ${VERSION_MINICONDA} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then
    mkdir -p /home/$(whoami)/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /home/$(whoami)/miniconda3/miniconda.sh
    bash /home/$(whoami)/miniconda3/miniconda.sh -b -u -p /home/$(whoami)/miniconda3
    rm /home/$(whoami)/miniconda3/miniconda.sh

    . ~/miniconda3/bin/activate
    sleep 2
    conda init
    sleep 2
    source ~/.bashrc
    sleep 2
fi
