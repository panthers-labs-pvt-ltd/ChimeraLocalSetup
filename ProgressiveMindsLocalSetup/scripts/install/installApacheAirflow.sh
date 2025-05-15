#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_AIRFLOW=$(getVersionToInstall "airflow")

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
  if [[ $(conda env list | grep env_airflow | wc -l) > 0 ]]; then
      source activate base
      conda activate env_airflow
      version_string=$( pip show apache-airflow | grep "Version" )
      if [[ $version_string == *"${VERSION_AIRFLOW}"* ]]; then
          echo "Airflow version ${VERSION_AIRFLOW} is already installed"
          installed=true
          conda deactivate
      fi
  fi
fi

if [ $installed = false ]; then
    echo "Installing Airflow via pip in miniconda environment"
    conda create -n env_airflow  --clone base
    source activate base
    conda activate env_airflow

    export AIRFLOW_HOME=~/airflow

    PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
    CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${VERSION_AIRFLOW}/constraints-${PYTHON_VERSION}.txt"
    pip install "apache-airflow==${VERSION_AIRFLOW}" --constraint "${CONSTRAINT_URL}"

    echo -e "\nAirflow is now installed in miniconda's 'env_airflow' environment. You can start the Airflow 'airflow standalone' within this env for development purposes."
    echo -e "\nYou can then connect to Airflow UI on http://localhost:8080. You would be provided with user id and password when airflow starts."
    echo -e "\nThis would also create airflow directory in /home/chimera. This is where all the SQLiteDB, logs, cfg and password would be saved."
    conda deactivate
    sleep 5
fi
