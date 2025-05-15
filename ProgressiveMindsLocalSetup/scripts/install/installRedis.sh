#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

VERSION_REDIS=$(getVersionToInstall "redis")

installed=false

if [[ $(which redis-server | wc -l) > 0 ]]; then
  version_string=$( redis-server --version | grep "Redis server" )
  if [[ $version_string == *"${VERSION_REDIS}"* ]]; then
    echo "Redis ${VERSION_REDIS} is already installed"
    installed=true
  fi
fi

if [ $installed = false ]; then
    sudo apt-get install lsb-release curl gpg
    curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
    sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
    sudo apt-get update
    sudo apt-get install redis

    echo -e "Redis (redis, redis-server, and redis-tools) is installed. It is in passwordless mode for Development purposes."
    echo -e "You can start redis-server using 'sudo service redis-server start' and then use redis-cli or other Java client like Redission or Jedis or Lettuce."
    sleep 5
fi
