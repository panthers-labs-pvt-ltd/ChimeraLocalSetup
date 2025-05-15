#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

datahubproject_version=$(getVersionToInstall "datahubproject")

installed=false

miniconda_installed=false

# It is not important to figure out if miniconda is installed or not.
# If installed, we should not worry more here.

if [[ $(which conda | wc -l) > 0 ]]; then
    miniconda_installed=true
else
    echo -e "\nMiniconda is not installed. Skipping installation. Please install minicode before running this."
    exit 0
fi

if [ $miniconda_installed = true ]; then
  if [[ $(conda env list | grep env_datahubproject | wc -l) > 0 ]]; then
      source activate base
      conda activate env_datahubproject
      version_string=$( pip show acryl-datahub | grep "Version" )
      if [[ $version_string == *"${datahubproject_version}"* ]]; then
          echo "Datahub version ${datahubproject_version} is already installed"
          installed=true
          conda deactivate
      fi
  fi
fi

# Assumption there is no way $miniconda_installed is false here 
if [ $installed = false ]; then
  echo "Installing Datahub Project via pip in miniconda environment"
    conda create -n env_datahubproject --clone base
    source activate base
    conda activate env_datahubproject

    python3 -m pip install --upgrade pip wheel setuptools
    python3 -m pip install --upgrade acryl-datahub
    datahubproject_version=$(datahub version)

    echo -e "\n Datahub version : $datahubproject_version"

    echo -e "\nDatahub version $datahubproject_version is now installed in miniconda's 'env_datahubproject' environment. You can start the env_datahubproject 'datahub docker quickstart' for development purposes within this env."
    echo -e "\nIf everything goes fine, you can ngest some demo data using `datahub docker ingest-sample-data`, or head to http://localhost:9002 (username: datahub, password: datahub) to play around with the frontend."
    conda deactivate
    sleep 5
fi
