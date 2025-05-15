#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

apachespark_version=$(getVersionToInstall "apachespark")

if [[ -d /opt/spark-$apachespark_version ]]; then
    echo -e "Spark $apachespark_version is already installed"
else
    wget https://dlcdn.apache.org/spark/spark-$apachespark_version/spark-$apachespark_version-bin-hadoop3.tgz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/spark-$apachespark_version-bin-hadoop3.tgz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/spark-$apachespark_version-bin-hadoop3/ /opt/spark-$apachespark_version
    sudo ln -s /opt/spark-$apachespark_version /opt/spark
    rm /home/$(whoami)/spark-$apachespark_version-bin-hadoop3.tgz

    copyFromScriptConfigLocalToHomeLocalBinEnv "configureSpark.sh"
    modifyBashrc "configureSpark.sh" ". ${HOMEDIR}/.local/bin/env/configureSpark.sh"
fi
