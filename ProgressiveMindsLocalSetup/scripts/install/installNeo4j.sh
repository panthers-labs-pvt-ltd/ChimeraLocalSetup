#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_NEO4J=$(getVersionToInstall "neo4j")

installed=false

if [[ $(which cypher-shell | wc -l) > 0 ]]; then
    version_string=$( cypher-shell --version | grep "Cypher-Shell" )
    if [[ $version_string == *"${VERSION_NEO4J}"* ]]; then
        echo "neo4j ${VERSION_NEO4J} is already installed"
        installed=true
    fi
fi

if [ $installed = false ]; then
    wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
    echo 'deb https://debian.neo4j.com stable 5' | sudo tee /etc/apt/sources.list.d/neo4j.list
    sudo apt-get update
    sudo apt-get install neo4j

    echo -e "neo4j is installed. The default credential: user - neo4j and password - neo4j."
    echo -e "You can start neo4j using 'sudo service neo4j start' and then login via http://localhost:7474 or use cypher-shell. When logging to cypher-shell, you would be prompted to change the password - please change it to Chimera@123"
    sleep 5
fi