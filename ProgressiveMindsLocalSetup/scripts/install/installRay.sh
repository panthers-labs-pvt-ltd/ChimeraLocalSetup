#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_RAY=$(getVersionToInstall "ray")

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
  if [[ $(conda env list | grep env_ray | wc -l) > 0 ]]; then
      source activate base
      conda activate env_ray
      version_string=$( pip show ray | grep "Version" )
      if [[ $version_string == *"${VERSION_RAY}"* ]]; then
          echo "Ray version ${VERSION_RAY} is already installed"
          installed=true
          conda deactivate
      fi
  fi
fi

if [ $installed = false ]; then
  echo "Installing Ray via pip in miniconda environment"
  conda create -n env_ray --clone base
  source activate base
  conda activate env_ray
  pip install -U "ray[all]"
  echo -e "\nRay is now installed in miniconda's 'env_ray' environment. You can start the Ray Dashboard using 'ray start --head --include-dashboard=true' within this env"
  conda deactivate
  sleep 5
fi
