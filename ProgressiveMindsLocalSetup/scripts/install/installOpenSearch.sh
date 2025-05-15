#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_OPENSEARCH=$(getVersionToInstall "opensearch")


if [[ -d /opt/opensearch-$VERSION_OPENSEARCH ]]; then
    echo "OpenSeach version $VERSION_OPENSEARCH is already installed"
else
    wget wget https://artifacts.opensearch.org/releases/bundle/opensearch/$VERSION_OPENSEARCH/opensearch-$VERSION_OPENSEARCH-linux-x64.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/opensearch-$VERSION_OPENSEARCH-linux-x64.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/opensearch-$VERSION_OPENSEARCH/ /opt/opensearch-$VERSION_OPENSEARCH
    sudo ln -s /opt/opensearch-$VERSION_OPENSEARCH /opt/opensearch
    rm /home/$(whoami)/opensearch-$VERSION_OPENSEARCH-linux-x64.tar.gz

    copyFromScriptConfigLocalToHomeLocalBinEnv "configureOpenSearch.sh"
    modifyBashrc "configureOpenSearch.sh" ". ${HOMEDIR}/.local/bin/env/configureOpenSearch.sh"
    . ${HOMEDIR}/.local/bin/env/configureOpenSearch.sh
    
    echo -e "OpenSearch is installed. Default password has been set to 'Chimera@123' for Development purposes."
    echo -e "\nOpenSearch logs are maintained at /var/log/opensearch/. Other important directories are /etc/opensearch/. /etc/opensearch/opensearch.yml is the main configuration file."
    echo -e "\nYou can start OpenSearch using 'cd /opt/opensearch' and './opensearch-tar-install.sh' and then connect to it using - https://localhost:9200 -u 'admin:Chimera@123' --insecure"
    echo -e "\nIf you are planning to use OpenSearch for backend to Data Catalog, please see - https://opensearch.org/docs/latest/install-and-configure/install-opensearch/debian/"
    echo -e "\nOpenSearch comes with its ecosystem consisting on Dashboard, SQL CLI, Ingestors, etc. - please let me know if you need anything more."
    sleep 5
fi
