#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

if [[ $(minikube version | wc -l) == 0 ]]; then

# Update package lists
echo "Updating package lists..."
sudo apt update

# Install dependencies
echo "Installing dependencies..."
sudo apt install -y curl apt-transport-https

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/$OS/$ARCH/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sudo rm kubectl

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-$OS-$ARCH
sudo install minikube-$OS-$ARCH /usr/local/bin/minikube
sudo rm minikube-$OS-$ARCH

# Install Minikube
echo "Adding $USER to docker Group Minikube..."
sudo usermod -aG docker $USER && newgrp docker

# Start Minikube with Docker driver
echo "Starting Minikube..."
minikube config set driver docker

sudo minikube start --driver=docker

echo "Minikube installation and configuration complete!"
modifyBashrc "minikube start" "minikube start"

else
  echo -e "Minikube is already installed: $(minikube version)\n"
fi
