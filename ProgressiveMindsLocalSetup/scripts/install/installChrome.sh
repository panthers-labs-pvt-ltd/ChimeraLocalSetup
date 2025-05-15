#!/bin/bash

set -euo pipefail

. ${DIR_ME}/.installUtils.sh

sudo apt --fix-broken install -y
sudo apt install -y fonts-liberation xdg-utils wget libgbm1

if [[ $(which google-chrome | wc -l) == 0 ]]; then
    curl -fSL https://dl.google.com/$OS/direct/google-chrome-stable_current_$ARCH.deb -o /tmp/google-chrome-stable_current_$ARCH.deb
    sudo dpkg -i /tmp/google-chrome-stable_current_$ARCH.deb
    rm /tmp/google-chrome-stable_current_$ARCH.deb
fi
