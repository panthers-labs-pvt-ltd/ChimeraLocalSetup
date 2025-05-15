#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

yunikorn_version=$(getVersionToInstall "yunikorn")
helm_version=$(getVersionToInstall "helm")

yunikorn_installed=false
helm_installed=false

if [[ $(which helm | wc -l) > 0 ]]; then
  version_string=$( helm version | grep "Version" )
  if [[ $version_string == *"v${helm_version}"* ]]; then
    echo "Helm version ${helm_version} is already installed"
    helm_installed=true
  fi
fi

# install helm
if [ $helm_installed = false ]; then
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
    sudo apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm
    helm_installed=true
fi

# if [[ $(which mongod | wc -l) > 0 ]]; then
#   version_string=$( mongod -version | grep "db version" )
#   if [[ $version_string == *"${VERSION_MONGODB}"* ]]; then
#     echo "MongoDB ${VERSION_MONGODB} is already installed"
#     yunikorn_installed=true
#   fi
# fi

if [ $yunikorn_installed = false ]; then
    helm repo add yunikorn https://apache.github.io/yunikorn-release
    helm repo update
    echo -e "\nEnsuring that minikube is up and running"
    if [[ $(minikube status | grep host | grep Running | wc -l ) = 0 ]]; then
        minikube start
    fi

    # create namespace if does not exist
    if [[ $( kubectl get namespace | grep yunikorn | wc -l) = 0 ]]; then
        kubectl create namespace yunikorn
        echo -e "\nNamespace yunikorn created"

        # ensure the latest is upgraded. -i would ensure to install if does not exist.
      helm upgrade -i yunikorn yunikorn/yunikorn --namespace yunikorn
      sleep 60 # It would take time for pod to be running. Putting 60 sec arbitrarily

      kubectl port-forward svc/yunikorn-service 9889:9889 -n yunikorn

      echo -e "Apache Yunikorn is added in helm. Further configuration would be done part of Development"

      # https://yunikorn.apache.org/docs/user_guide/observability/prometheus

    sleep 5
    else
      echo -e "\nYunkorn has already been added in kubectl via helm"
    fi
fi
