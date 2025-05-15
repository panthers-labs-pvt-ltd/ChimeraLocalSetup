#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

echo "OpenVSCodeServer helps run upstream VS Code on a remote machine with access through a modern web browser from any device, anywhere."

# check if this already installed

OPENVSCODE_SERVER_VERSION=$(getVersionToInstall "openvscodeServer")

url="https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-${OPENVSCODE_SERVER_VERSION}/openvscode-server-${OPENVSCODE_SERVER_VERSION}-$OS-x64.tar.gz"

installed=false

if [[ -d ${HOMEDIR}/.local/openvscode-server ]]; then
  version_string=$( grep version ~/.local/openvscode-server/latest/package.json | grep "version" )
  if [[ $version_string == *"${OPENVSCODE_SERVER_VERSION:1}"* ]]; then
    echo "openvscode-server version ${OPENVSCODE_SERVER_VERSION} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then
  if [[ ! -d ${HOMEDIR}/.local/openvscode-server/logs ]]; then
    mkdir -p ${HOMEDIR}/.local/openvscode-server/logs
  fi

  curl -fSL $url -o ${HOMEDIR}/.local/openvscode-server/openvscode-server-$OS-x64.tar.gz
  tar -xzf ${HOMEDIR}/.local/openvscode-server/openvscode-server-$OS-x64.tar.gz -C ${HOMEDIR}/.local/openvscode-server
  ln -s  ${HOMEDIR}/.local/openvscode-server/openvscode-server-${OPENVSCODE_SERVER_VERSION}-$OS-x64 ${HOMEDIR}/.local/openvscode-server/latest
  rm ${HOMEDIR}/.local/openvscode-server/openvscode-server-$OS-x64.tar.gz

  copyFromScriptConfigLocalToHomeLocalBinEnv "configureOpenVSCodeServer.sh"
  modifyBashrc "configureOpenVSCodeServer.sh" "~/.local/openvscode-server/latest/server.sh &>> ~/.local/openvscode-server/logs/openvscode-server.log &"
fi