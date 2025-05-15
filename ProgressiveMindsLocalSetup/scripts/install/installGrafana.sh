#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_GRAFANA=$(getVersionToInstall "grafana")

installed=false

if [[ $(which grafana-server | wc -l) > 0 ]]; then
    version_string=$( grafana-server --version | grep "Version" )
    if [[ $version_string == *"${VERSION_GRAFANA}"* ]]; then
        echo "Grafana ${VERSION_GRAFANA} is already installed"
        installed=true
    fi
fi

if [ $installed = false ]; then
    sudo apt-get install -y apt-transport-https software-properties-common wget
    wget -q -O - https://apt.grafana.com/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/grafana.gpg | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    sudo apt-get update
    sudo apt-get install grafana

    echo -e "\nGrafana is installed. The default credential: user - admin and password - admin."
    echo -e "\nYou can start Grafana using 'sudo service grafana-server start' and then login via http://localhost:3000. When logging to Grafana, you would be prompted to change the password - please change it to Chimera@123"
    sleep 5
fi
