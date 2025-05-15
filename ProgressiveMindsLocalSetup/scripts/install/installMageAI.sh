#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_MAGEAI=$(getVersionToInstall "mage-ai")

installed=false

miniconda_installed=false

if [[ $(which conda | wc -l) > 0 ]]; then
  VERSION_MINICONDA=$(getVersionToInstall "miniconda")
  version_string=$( conda --version | grep "conda" )
  if [[ $version_string == *"${VERSION_MINICONDA}"* ]]; then
    echo "miniconda ${VERSION_MINICONDA} is installed. Progressing.."
    miniconda_installed=true
  fi
fi

if [ $miniconda_installed = false ]; then
    . ${DIR_ME}/installMiniConda.sh
fi

if [ $miniconda_installed = true ]; then
  if [[ $( conda env list | grep env_mage-ai | wc -l) > 0 ]]; then
      source activate base
      conda activate env_mage-ai
      version_string=$( pip show mage-ai | grep "Version" )
      if [[ $version_string == *"${VERSION_MAGEAI}"* ]]; then
          echo "Mage-AI version ${VERSION_MAGEAI} is already installed"
          installed=true
          conda deactivate
      fi
  fi
fi

if [ $installed = false ]; then
    echo "Installing Mage-AI via pip in miniconda environment"
    conda create -n env_mage-ai --clone base
    source activate base
    conda activate env_mage-ai

    pip install mage-ai 

    echo -e "\nMage-AI is now installed in miniconda's 'env_mage-ai' environment. You can start the Mage-AI 'mage start [project-name]' for development purposes within this env."
    echo -e "\nYou can then connect to Mage-AI UI on http://localhost:6789."
    conda deactivate
    sleep 5
fi
