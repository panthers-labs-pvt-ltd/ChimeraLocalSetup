#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

apachedruid_version=$(getVersionToInstall "apachedruid")

if [[ -d /opt/apache-druid-$apachedruid_version ]]; then
    echo -e "druid $apachedruid_version is already installed"
else
    wget https://dlcdn.apache.org/druid/$apachedruid_version/apache-druid-$apachedruid_version-bin.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/apache-druid-$apachedruid_version-bin.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/apache-druid-$apachedruid_version/ /opt/apache-druid-$apachedruid_version
    sudo ln -s /opt/apache-druid-$apachedruid_version /opt/druid
    rm /home/$(whoami)/apache-druid-$apachedruid_version-bin.tar.gz

    copyFromScriptConfigLocalToHomeLocalBinEnv "configureDruid.sh"
    modifyBashrc "configureDruid.sh" ". ${HOMEDIR}/.local/bin/env/configureDruid.sh"

    echo -e "\nDruid version $apachedruid_version is installed. You can run 'cd /opt/druid' and './bin/start-druid'. This launches Zookeeper and Druid services. You can access the UI at http://localhost:8888/"
    echo -e "\nPlease note Druid can take up a lot of memory, and hence I recommend to set up in a separate cluster. Please read more at https://druid.apache.org/docs/latest/tutorials/"
    sleep 5
fi
