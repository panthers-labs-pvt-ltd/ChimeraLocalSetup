#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))


# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

VERSION_MAVEN=$(getVersionToInstall "maven")

installed=false

if [[ $(which mvn | wc -l) > 0 ]]; then
  version_string=$( mvn --version | grep "Apache Maven" )
  if [[ $version_string == *"${VERSION_MAVEN}"* ]]; then
    echo "maven ${VERSION_MAVEN} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then

	# ensure old installation directories are removed as well
	if [[ -d /usr/share/maven ]]; then
		sudo rm -fr /usr/share/maven
	fi

	sudo mkdir -p /usr/lib/maven

	# download & unpack
	if [[ ! -e ${HOMEDIR}/Downloads/apache-maven-${VERSION_MAVEN}-bin.tar.gz ]]; then
		curl -fSL https://apache.osuosl.org/maven/maven-3/${VERSION_MAVEN}/binaries/apache-maven-${VERSION_MAVEN}-bin.tar.gz -o ${HOMEDIR}/Downloads/apache-maven-${VERSION_MAVEN}-bin.tar.gz
	fi
	sudo tar -xzf ${HOMEDIR}/Downloads/apache-maven-${VERSION_MAVEN}-bin.tar.gz -C /usr/lib/maven --strip-components=1

	if [[ ! -d ${HOMEDIR}/.m2 ]]; then
		mkdir -p ${HOMEDIR}/.m2
	fi

	USE_WIN_M2=${1-""}
	# only use windows m2 if told to do so
	if [[ ${USE_WIN_M2} == "--useWinM2" ]]; then

		if [[ -n ${WINDOWS_USER_HOME} ]]; then

			if [[ -f ${WINDOWS_USER_HOME}/.m2/settings.xml ]]; then
				cp -f ${WINDOWS_USER_HOME}/.m2/settings.xml ${HOMEDIR}/.m2
				sed -i "s:<localRepository>.*<:<localRepository>${WINDOWS_USER_HOME}/.m2/repository<:g" ${HOMEDIR}/.m2/settings.xml
			else
				echo "<settings><localRepository>${WINDOWS_USER_HOME}/.m2/repository</localRepository></settings>" > ${HOMEDIR}/.m2/settings.xml
			fi
		fi
	fi

	copyFromScriptConfigLocalToHomeLocalBinEnv "configureJvmEnv.sh"
	modifyBashrc "configureJvmEnv.sh" ". ${HOMEDIR}/.local/bin/env/configureJvmEnv.sh"
fi
