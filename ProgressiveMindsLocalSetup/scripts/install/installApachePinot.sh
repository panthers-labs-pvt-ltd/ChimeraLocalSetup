#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

PINOT_VERSION=$(getVersionToInstall "apachepinot")

if [[ -d /opt/apache-pinot-$PINOT_VERSION-bin ]]; then
    echo -e "Pinot $PINOT_VERSION is already installed"
else
    wget https://downloads.apache.org/pinot/apache-pinot-$PINOT_VERSION/apache-pinot-$PINOT_VERSION-bin.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/apache-pinot-$PINOT_VERSION-bin.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/apache-pinot-$PINOT_VERSION-bin/ /opt/apache-pinot-$PINOT_VERSION-bin
    sudo ln -s /opt/apache-pinot-$PINOT_VERSION-bin /opt/pinot
    rm /home/$(whoami)/apache-pinot-$PINOT_VERSION-bin.tar.gz

    copyFromScriptConfigLocalToHomeLocalBinEnv "configurePinot.sh"
    modifyBashrc "configurePinot.sh" ". ${HOMEDIR}/.local/bin/env/configurePinot.sh"

    echo -e "\nPinot version $PINOT_VERSION is installed. You can run 'cd /opt/pinot' and './bin/pinot-admin.sh QuickStart -type batch'. This launches basic set up with support up to few MBs of data."
    echo -e "\nFor full fledged set up - please see https://docs.pinot.apache.org/basics/getting-started/running-pinot-locally#manual-cluster"
    sleep 5
fi
