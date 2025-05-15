#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

IDEA_VERSION=$(getVersionToInstall "idea")

installed=false

if [[ -d /opt/intellij-idea-community ]]; then
  version_string=$( cat /opt/intellij-idea-community/product-info.json | grep '"version":' )
  if [[ $version_string == *"${IDEA_VERSION}"* ]]; then
    echo "IntelliJ Community Version ${IDEA_VERSION} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then

	DOWNLOAD_URL="https://download.jetbrains.com/idea/ideaIC-${IDEA_VERSION}.tar.gz"

	# ensure old installation directories are removed as well
	sudo rm -fr /opt/intellij-idea-community
	sudo mkdir -p /opt/intellij-idea-community

	# download & unpack
	if [[ ! -e ${HOMEDIR}/Downloads/ideaIC-latest.tar.gz ]]; then
		curl -fSL $DOWNLOAD_URL -o ${HOMEDIR}/Downloads/ideaIC-${IDEA_VERSION}.tar.gz
	fi
	sudo tar -xzf ${HOMEDIR}/Downloads/ideaIC-${IDEA_VERSION}.tar.gz -C /opt/intellij-idea-community --strip-components=1
	modifyBashrc "idea.sh" "alias idea='nohup /opt/intellij-idea-community/bin/idea.sh > $HOME/idea.out 2> $HOME/idea.err < /dev/null &'"
fi
