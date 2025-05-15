#!/bin/sh

UPDATED_PATH=${PATH}

# . ${DIR_ME}/.installUtils.sh
# setUserName ${1-"$(whoami)"}

#java_version=$(getVersionToInstall "java")

#TODO remove hard-coding
java_version=17

if [[ -d /opt/gradle/bin ]]; then
    UPDATED_PATH=/opt/gradle/bin:${UPDATED_PATH}
fi

if [[ -d /usr/lib/maven ]]; then
    export M2_HOME=/usr/lib/maven
    export MAVEN_HOME=/usr/lib/maven
    UPDATED_PATH=${M2_HOME}/bin:${UPDATED_PATH}
fi

if [[ -d /usr/lib/jvm/java-${java_version}-openjdk-$ARCH ]]; then
    export JAVA_HOME=/usr/lib/jvm/java-${java_version}-openjdk-$ARCH
    UPDATED_PATH=${JAVA_HOME}/bin:${UPDATED_PATH}
fi

export PATH=${UPDATED_PATH}
