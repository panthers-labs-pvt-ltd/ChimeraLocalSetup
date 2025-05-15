#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

apachekafka_version=$(getVersionToInstall "apachekafka")
scala_version=$(getVersionToInstall "scala")

if [[ -d /opt/kafka_$scala_version-$apachekafka_version ]]; then
    echo -e "Kafka $scala_version-$apachekafka_version is already installed"
else
    wget https://dlcdn.apache.org/kafka/$apachekafka_version/kafka_$scala_version-$apachekafka_version.tgz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/kafka_$scala_version-$apachekafka_version.tgz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/kafka_$scala_version-$apachekafka_version /opt/kafka_$scala_version-$apachekafka_version
    sudo ln -s /opt/kafka_$scala_version-$apachekafka_version /opt/kafka
    rm /home/$(whoami)/kafka_$scala_version-$apachekafka_version.tgz

    modifyBashrc "Apache Kafka" "PATH=$PATH:/opt/kafka/bin"

    echo -e "Kafka $scala_version-$apachekafka_version is installed. Proceeding to set up a basic standalone cluster."

fi

if [[ ! -d /tmp/kraft-combined-logs ]]; then
    KAFKA_CLUSTER_ID="$(/opt/kafka/bin/kafka-storage.sh random-uuid)"
    echo -e "\nKafka Cluster ID - $KAFKA_CLUSTER_ID. !!! DO NOT CREATE MULTIPLE CLUSTER ID !!! It won't work."
    
    /opt/kafka/bin/kafka-storage.sh format --standalone -t $KAFKA_CLUSTER_ID -c /opt/kafka/config/kraft/reconfig-server.properties
    echo -e "\nLog directory is formatted using cluster UUID and config/kraft/reconfig-server.properties"
    echo -e "\nLog directories are the folders where Kafka stores its data as ordered sequences of messages called logs. Each log is divided into smaller files called segments, which contain the actual messages and some index files to help locate them. Log directories are organized by topics and partitions, which are logical groups of logs that belong to a specific use case and provide parallelism and fault tolerance."

    echo -e "\nYou can start the server using 'bin/kafka-server-start.sh /opt/kafka/config/kraft/reconfig-server.properties'"
else
    echo -e "Kafka logs are already formatted with cluster id - $(cat /tmp/kraft-combined-logs/meta.properties | grep cluster.id | cut -d "=" -f2)"
fi
