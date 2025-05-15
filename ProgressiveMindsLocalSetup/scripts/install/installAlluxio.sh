#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

alluxio_version=$(getVersionToInstall "alluxio")

if [[ -d /opt/alluxio-$alluxio_version ]]; then
    echo -e "Alluxio $alluxio_version is already installed"
else
    wget https://downloads.alluxio.io/downloads/files/$alluxio_version/alluxio-$alluxio_version-bin.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/alluxio-$alluxio_version-bin.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/alluxio-$alluxio_version/ /opt/alluxio-$alluxio_version
    sudo ln -s /opt/alluxio-$alluxio_version /opt/alluxio
    rm /home/$(whoami)/alluxio-$alluxio_version-bin.tar.gz

    copyFromScriptConfigLocalToHomeLocalBinEnv "configureAlluxio.sh"
    modifyBashrc "configureAlluxio.sh" ". ${HOMEDIR}/.local/bin/env/configureAlluxio.sh"

    . ${HOMEDIR}/.local/bin/env/configureAlluxio.sh

    echo "Alluxio Home - $ALLUXIO_HOME"

    echo -e "\nSetting Alluxio environment for local run..."
    cp $ALLUXIO_HOME/conf/alluxio-env.sh.template $ALLUXIO_HOME/conf/alluxio-env.sh
    echo "JAVA_HOME=$JAVA_HOME" >> /opt/alluxio/conf/alluxio-env.sh
    cp $ALLUXIO_HOME/conf/alluxio-site.properties.template $ALLUXIO_HOME/conf/alluxio-site.properties
    echo "alluxio.master.hostname=localhost" >> $ALLUXIO_HOME/conf/alluxio-site.properties

    echo -e "\nValidating Alluxio environment..."
    $ALLUXIO_HOME/bin/alluxio validateEnv local

    $ALLUXIO_HOME/bin/alluxio format

    echo -e "\nAlluxio version $alluxio_version is install. You start please run command '$ALLUXIO_HOME/bin/alluxio local SudoMount'"
    sleep 5
fi
