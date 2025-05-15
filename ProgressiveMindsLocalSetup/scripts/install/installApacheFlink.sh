#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

apacheflink_version=$(getVersionToInstall "apacheflink")

if [[ -d /opt/flink-$apacheflink_version ]]; then
    echo -e "Apache Flink $apacheflink_version is already installed"
else
    wget https://dlcdn.apache.org/flink/flink-$apacheflink_version/flink-$apacheflink_version-bin-scala_2.12.tgz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/flink-$apacheflink_version-bin-scala_2.12.tgz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/flink-$apacheflink_version/ /opt/flink-$apacheflink_version
    sudo ln -s /opt/flink-$apacheflink_version /opt/flink
    rm /home/$(whoami)/flink-$apacheflink_version-bin-scala_2.12.tgz

    copyFromScriptConfigLocalToHomeLocalBinEnv "configureFlink.sh"
    modifyBashrc "configureFlink.sh" ". ${HOMEDIR}/.local/bin/env/configureFlink.sh"
fi