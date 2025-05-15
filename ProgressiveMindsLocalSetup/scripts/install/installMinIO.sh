#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

minio_version=$(getVersionToInstall "minio")

installed=false

if [[ $(which ~/minio | wc -l) > 0 ]]; then
    version_string=$( ~/minio --version | grep version )
    if [[ $version_string == *"${minio_version}"* ]]; then
        echo "minio release ${minio_version} is already installed"
    else
        echo "minio auto-upgrade is not allowed. Please get in touch with engineering team."
  fi
  installed=true
fi

if [ $installed = false ]; then
    echo "Downloading the MinIO server"
    
    wget https://dl.min.io/server/minio/release/$OS-$ARCH/minio -O /home/$(whoami)/minio
    chmod +x /home/$(whoami)/minio

    modifyBashrc "minio-user" "MINIO_ROOT_USER=admin"
    modifyBashrc "minio-root-password" "MINIO_ROOT_PASSWORD=password"
    modifyBashrc "minio-run-alias" "alias run_minio='nohup ~/minio server ~/minio-data --address 0.0.0.0:9000 --console-address 0.0.0.0:9001 > ~/minio.out 2> ~/minio.err < /dev/null &'"

    source /home/$(whoami)/.bashrc
    echo "The script deployed MinIO in a Single-Node Single-Drive (SNSD) configuration for early development and evaluation. SNSD deployments use a zero-parity erasure coded backend that provides no added reliability or availability beyond what the underlying storage volume implements. These deployments are best suited for local testing and evaluation, or for small-scale data workloads that do not have availability or performance requirements."
    echo -e "\nYou can run minio in background using the alias 'run_minio'"
    sleep 5
fi
