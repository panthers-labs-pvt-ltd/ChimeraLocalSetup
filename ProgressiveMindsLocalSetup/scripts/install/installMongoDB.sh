#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_MONGODB=$(getVersionToInstall "mongodb")

installed=false

if [[ $(which mongod | wc -l) > 0 ]]; then
  version_string=$( mongod -version | grep "db version" )
  if [[ $version_string == *"${VERSION_MONGODB}"* ]]; then
    echo "MongoDB ${VERSION_MONGODB} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then
    sudo apt-get install gnupg curl
    curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg
    echo "deb [ arch=$ARCH,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org

    echo -e "MongoDB is installed. It is in passwordless mode for Development purposes."
    echo -e "\nThe data directory /var/lib/mongodb and the log directory /var/log/mongodb are created during the installation. As default, MongoDB runs using the mongodb user account."
    echo -e "\nMongoDB configuration file is present at /etc/mongod.conf"
    echo -e "\nYou can start mongo using 'sudo service mongod start' and then use 'mongosh' which connects to mongod running on default port 27017."
    sleep 5
fi
