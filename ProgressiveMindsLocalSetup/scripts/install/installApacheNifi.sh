#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

apachenifi_version=$(getVersionToInstall "apachenifi")

if [[ -d /opt/nifi-$apachenifi_version ]]; then
    echo -e "Apache Nifi $apachenifi_version is already installed"
else
    wget https://dlcdn.apache.org/nifi/$apachenifi_version/nifi-$apachenifi_version-bin.zip -P /home/$(whoami)
    unzip /home/$(whoami)/nifi-$apachenifi_version-bin.zip -d /home/$(whoami)/
    sudo mv /home/$(whoami)/nifi-$apachenifi_version/ /opt/nifi-$apachenifi_version
    sudo ln -s /opt/nifi-$apachenifi_version /opt/nifi
    rm /home/$(whoami)/nifi-$apachenifi_version-bin.zip

    echo -e "\nApache Nifi $apachenifi_version has been installed. Creating a user to log in..."

    /opt/nifi/bin/nifi.sh set-single-user-credentials chimera Chimera@1234

    echo -e "\nTo run NiFi in the foreground, run bin/nifi.sh run. This will leave the application running until the user presses Ctrl-C. At that time, it will initiate shutdown of the application."
    echo -e "\nTo run NiFi in the background, instead run bin/nifi.sh start. This will initiate the application to begin running. To check the status and see if NiFi is currently running, execute the command bin/nifi.sh status. NiFi can be shutdown by executing the command bin/nifi.sh stop."
    echo -e "\nNow that NiFi has been started, we can bring up the User Interface (UI) in order to create and monitor our dataflow. To get started, open a web browser and navigate to https://localhost:8443/nifi. Please use user - chimera and password - Chimera@1234"

    sleep 5

fi
