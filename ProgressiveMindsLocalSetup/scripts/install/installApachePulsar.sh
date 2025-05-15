#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

apachepulsar_version=$(getVersionToInstall "apachepulsar")

if [[ -d /opt/apache-pulsar-$apachepulsar_version ]]; then
    echo -e "Apache Pulsar $apachepulsar_version is already installed"
else
    wget https://archive.apache.org/dist/pulsar/pulsar-$apachepulsar_version/apache-pulsar-$apachepulsar_version-bin.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/apache-pulsar-$apachepulsar_version-bin.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/apache-pulsar-$apachepulsar_version /opt/apache-pulsar-$apachepulsar_version
    sudo ln -s /opt/apache-pulsar-$apachepulsar_version /opt/pulsar
    rm /home/$(whoami)/apache-pulsar-$apachepulsar_version-bin.tar.gz

    copyFromScriptConfigLocalToHomeLocalBinEnv "configurePulsar.sh"
    modifyBashrc "configurePulsar.sh" ". ${HOMEDIR}/.local/bin/env/configurePulsar.sh"

    echo -e "\nApache Pulsar $apachepulsar_version is installed. To run basic standalone cluster, run 'pulsar standalone'."
    echo -e "\nPlease note Apache Pulsar needs more memory. You should increase the memory on WSL."
    echo -e "\nPlease check free memory in WSL using 'free -h'. If it is less that 2GB, update 'memory=6GB' in C:\Users\<user>\.wslconfig. After that do a wsl --shutdown and then log back in. You should be okay."
    sleep 20
fi
