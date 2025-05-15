#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

prometheus_version=$(getVersionToInstall "prometheus")

if [[ -d /opt/prometheus-$prometheus_version.$OS-$ARCH ]]; then
    echo -e "Prometheus $prometheus_version is already installed"
else
    wget https://github.com/prometheus/prometheus/releases/download/v$prometheus_version/prometheus-$prometheus_version.$OS-$ARCH.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/prometheus-$prometheus_version.$OS-$ARCH.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/prometheus-$prometheus_version.$OS-$ARCH/ /opt/prometheus-$prometheus_version.$OS-$ARCH
    sudo ln -s /opt/prometheus-$prometheus_version.$OS-$ARCH /opt/prometheus
    rm /home/$(whoami)/prometheus-$prometheus_version.$OS-$ARCH.tar.gz

    echo -e "\nPrometheus version $prometheus_version is installed. However, it cannot be used as is."
    echo -e "\nPrometheus requires configuration file named 'prometheus.yml', which can then be used to start prometheus using './prometheus --config.file=prometheus.yml'" 
    echo -e "\nYou can use Prometheus as backend for OpenTelemetry"
    sleep 5
fi

echo -e "\nPrometheus also requires a number of other utilities - node-exporter, alertmanager, etc. Progressing to set up node-exporter and alertmanager..."

node_exporter_version=$(getVersionToInstall "node_exporter")

if [[ -d /opt/node_exporter-$node_exporter_version.$OS-$ARCH ]]; then
    echo -e "\nnode_export $node_exporter_version is already installed"
else
    # NOTE: Replace the URL with one from the above mentioned "downloads" page.
    # <VERSION> are placeholders.
    wget https://github.com/prometheus/node_exporter/releases/download/v$node_exporter_version/node_exporter-$node_exporter_version.$OS-$ARCH.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/node_exporter-$node_exporter_version.$OS-$ARCH.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/node_exporter-$node_exporter_version.$OS-$ARCH/ /opt/node_exporter-$node_exporter_version.$OS-$ARCH
    sudo ln -s /opt/node_exporter-$node_exporter_version.$OS-$ARCH /opt/node_manager
    rm /home/$(whoami)/node_exporter-$node_exporter_version.$OS-$ARCH.tar.gz
    
    echo -e "\nnode_export $node_exporter_version is installed. You can start by 'cd /opt/node_exporter and ./node_exporter'. You should see it running and exposing metrics on port 9100"
    sleep 5
fi

alertmanager_version=$(getVersionToInstall "alertmanager")

if [[ -d /opt/alertmanager-$alertmanager_version.$OS-$ARCH ]]; then
    echo -e "\nAlertManager $alertmanager_version is already installed"
else
    wget https://github.com/prometheus/alertmanager/releases/download/v$alertmanager_version/alertmanager-$alertmanager_version.$OS-$ARCH.tar.gz -P /home/$(whoami)
    tar -xvf /home/$(whoami)/alertmanager-$alertmanager_version.$OS-$ARCH.tar.gz -C /home/$(whoami)/
    sudo mv /home/$(whoami)/alertmanager-$alertmanager_version.$OS-$ARCH/ /opt/alertmanager-$alertmanager_version.$OS-$ARCH
    sudo ln -s /opt/alertmanager-$alertmanager_version.$OS-$ARCH /opt/alertmanager
    rm /home/$(whoami)/alertmanager-$alertmanager_version.$OS-$ARCH.tar.gz
    
    echo -e "\nAlertManager version $alertmanager_version is installed. This also needs a configuration file to run - 'cd /opt/alertmanager' and './alertmanager --config.file=alertmanager.yml'"
    sleep 5
fi
