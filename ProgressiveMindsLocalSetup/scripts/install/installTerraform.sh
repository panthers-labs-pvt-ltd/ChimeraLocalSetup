#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

terraform_version=$(getVersionToInstall "terraform")

installed=false

if [[ $(which terraform | wc -l) > 0 ]]; then
    version_string=$( terraform -version | grep "Terraform" )
    if [[ $version_string == *"${terraform_version}"* ]]; then
        echo "Terraform ${terraform_version} is already installed"
        installed=true
    fi
fi

if [ $installed = false ]; then
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform

    echo -e "\nCode assumes that you have setup your source code using this script."
    cd ~/projects/IaC/terraform && terraform init
    echo -e "\nTerraform is installed and initialized with ~/projects/IaC/terraform"
    sleep 5
fi
