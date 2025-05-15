#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

cassandra_version=$(getVersionToInstall "cassandra")

if [[ -d /opt/apache-cassandra-$cassandra_version ]]; then
    echo -e "Cassandra $cassandra_version is already installed"
else
    wget https://dlcdn.apache.org/cassandra/$cassandra_version/apache-cassandra-$cassandra_version-bin.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/apache-cassandra-$cassandra_version-bin.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/apache-cassandra-$cassandra_version/ /opt/apache-cassandra-$cassandra_version
    sudo ln -s /opt/apache-cassandra-$cassandra_version /opt/cassandra
    rm /home/$(whoami)/apache-cassandra-$cassandra_version-bin.tar.gz

    echo -e "\nCassandra version $cassandra_version is installed. To start Apache Cassandra, you can 'cd /opt/cassandra' and './bin/cassandra'"
    echo -e "\nPlease note bin/cqlsh does not support Python 3.12. It is known problem - https://issues.apache.org/jira/browse/CASSANDRA-19206"
    echo -e "\nAttempting to create Python environment 'python3_9' for cassandra with Python 3.9"
fi

if [[ $(conda env list | grep python3_9 | wc -l) > 0 ]]; then
    echo -e "python3_9 env already exists"
else
    conda create -n python3_9 python=3.9
    echo -e "\nPython environment python3_9 create for cassandra with Python 3.9. Please run 'conda activate python3_9' to use"
fi
