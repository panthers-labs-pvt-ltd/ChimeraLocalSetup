#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

VERSION_GRADLE=$(getVersionToInstall "gradle")

installed=false

if [[ $(which gradle | wc -l) > 0 ]]; then
  version_string=$( gradle --version | grep "Gradle" )
  if [[ $version_string == *"${VERSION_GRADLE}"* ]]; then
    echo "Gradle ${VERSION_GRADLE} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then
	# download & unpack
	if [[ ! -e ${HOMEDIR}/Downloads/gradle-${VERSION_GRADLE}-bin.zip ]]; then
		curl -fSL https://services.gradle.org/distributions/gradle-${VERSION_GRADLE}-bin.zip -o ${HOMEDIR}/Downloads/gradle-${VERSION_GRADLE}-bin.zip
	fi
	sudo unzip -d /opt/gradle.tmp ${HOMEDIR}/Downloads/gradle-${VERSION_GRADLE}-bin.zip
	sudo mv /opt/gradle.tmp/gradle-${VERSION_GRADLE}/ /opt/gradle/
	sudo rmdir /opt/gradle.tmp

	copyFromScriptConfigLocalToHomeLocalBinEnv "configureJvmEnv.sh"
	modifyBashrc "configureJvmEnv.sh" ". ${HOMEDIR}/.local/bin/env/configureJvmEnv.sh"
fi

