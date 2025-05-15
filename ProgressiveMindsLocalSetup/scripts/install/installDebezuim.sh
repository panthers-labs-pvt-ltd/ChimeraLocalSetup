#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

debezium_version=$(getVersionToInstall "debezium")

if [[ -d /opt/debezium-server-dist-${debezium_version} ]]; then
    echo -e "Debezium $debezium_version is already installed"
else
    wget https://repo1.maven.org/maven2/io/debezium/debezium-server-dist/${debezium_version}.Final/debezium-server-dist-${debezium_version}.Final.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/debezium-server-dist-${debezium_version}.Final.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/debezium-server /opt/debezium-server-dist-${debezium_version}
    sudo ln -s /opt/debezium-server-dist-${debezium_version} /opt/debezium
    rm /home/$(whoami)/debezium-server-dist-${debezium_version}.Final.tar.gz

    copyFromScriptConfigLocalToHomeLocalBinEnv "configureDebezium.sh"
    modifyBashrc "configureDebezium.sh" ". ${HOMEDIR}/.local/bin/env/configureDebezium.sh"

    echo -e "\nDebezium Server version $debezium_version is installed. To start Debezium, you can cd into /opt/debezium and enter '. run.sh'"
    echo -e "\nPlease note that you would need to set the connectors, sink, etc. Please read Debezium to use it effectively."

    sleep 5
fi
