#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

VERSION_DENO=$(getVersionToInstall "deno")

installed=false

if [[ -d ~/.deno/bin ]]; then
    # Think about upgrade later
    echo -e "Deno is already installed"
else
  echo "Installing Deno. Deno (/ˈdiːnoʊ/, pronounced dee-no) is an open source JavaScript, TypeScript, and WebAssembly runtime with secure defaults and a great developer experience. It's built on V8, Rust, and Tokio."

  sudo apt install -y unzip
  cp ${HOMEDIR}/.bashrc ${HOMEDIR}/.bashrc.bak
  curl -fsSL https://deno.land/x/install/install.sh | sh
  mv ${HOMEDIR}/.bashrc.bak ${HOMEDIR}/.bashrc

  copyFromScriptConfigLocalToHomeLocalBinEnv "configureDeno.sh"
  modifyBashrc "configureDeno.sh" ". ${HOMEDIR}/.local/bin/env/configureDeno.sh"

  . ${HOMEDIR}/.local/bin/env/configureDeno.sh
fi

