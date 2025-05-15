#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_POLARS=$(getVersionToInstall "polars")

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
    miniconda_installed=true
fi

if [ $miniconda_installed = true ]; then
  source activate base
  if [[ -d ~/miniconda3/lib/python3.12/site-packages/polars ]]; then
    version_string=$( pip show polars | grep "Version" )
    if [[ $version_string == *"${VERSION_POLARS}"* ]]; then
      echo "Polars version ${VERSION_POLARS} is already installed"
      installed=true
    fi
  fi
fi

# Assumption there is no way $miniconda_installed is false here 
if [ $installed = false ]; then
  echo "Please note that this version polars supports ~4.3 billion rows within Polars dataframes"
  source activate base
  pip install polars
  echo -e "\nPolars is now installed in miniconda's base environment."
fi
