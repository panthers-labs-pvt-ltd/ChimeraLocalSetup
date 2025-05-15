#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_DOCKER_COMPOSE=$(getVersionToInstall "docker-compose")

installed=false

if [[ $(which docker compose | wc -l) > 0 ]]; then
  version_string=$( docker compose version | grep "version" )
  if [[ $version_string == *"${VERSION_DOCKER_COMPOSE:1}"* ]]; then
    echo "docker compose version ${VERSION_DOCKER_COMPOSE} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then
  sudo apt update
  sudo apt remove docker docker.io containerd runc
  sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

  sudo curl -fsSL https://download.docker.com/$OS/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=$ARCH] https://download.docker.com/$OS/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y --no-install-recommends docker-ce

  if [[ ! -d ~/.docker/cli-plugins ]]; then
    mkdir -p ~/.docker/cli-plugins
  fi
  curl -fSL https://github.com/docker/compose/releases/download/${VERSION_DOCKER_COMPOSE}/docker-compose-$OS-x86_64 -o ~/.docker/cli-plugins/docker-compose
  chmod +x ~/.docker/cli-plugins/docker-compose
  modifyBashrc "sudo service docker start" "sudo service docker start"
fi
