#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

duckDB_version=$(getVersionToInstall "duckDB")

if [[ -f /home/$(whoami)/duckdb_cli-${duckDB_version}-$OS-$ARCH.zip ]]; then
    echo -e "DuckDB $duckDB_version is already installed"
else
    wget https://github.com/duckdb/duckdb/releases/download/v${duckDB_version}/duckdb_cli-$OS-$ARCH.zip -P /home/$(whoami)
    mv /home/$(whoami)/duckdb_cli-$OS-$ARCH.zip /home/$(whoami)/duckdb_cli-${duckDB_version}-$OS-$ARCH.zip
    unzip /home/$(whoami)/duckdb_cli-${duckDB_version}-$OS-$ARCH.zip -d /home/$(whoami)/
    
    echo -e "DuckDB version $duckDB_version is installed. Please DO NOT delete the file /home/$(whoami)/duckdb_cli-${duckDB_version}-$OS-$ARCH.zip - it is currently used to track state of developer machine. We will fix this in future."
    sleep 10
fi
