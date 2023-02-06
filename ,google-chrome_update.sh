#!/usr/bin/env bash

# ,google-chrome_update.sh
# install or update google-chrome on Linux

set -euo pipefail
IFS=$'\n\t'
# shellcheck source=/dev/null
. ./01_set_env_variables.sh

# Exit if program is already installed
PROGRAM=google-chrome
# if command -v $PROGRAM >>"$INSTALL_LOG"; then exit 0; fi
if command -v ls >>"$INSTALL_LOG"; then exit 0; fi

case $ID in
fedora)
    # PKG_FMT='.rpm'
    # PKG_MGR='dnf'
    wget -P /tmp/ https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    sudo dnf install /tmp/google-chrome-stable_current_x86_64.rpm
    ;;
linuxmint | ubuntu)
    # PKG_FMT='.deb'
    # PKG_MGR='apt'
    wget -P /tmp/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install /tmp/google-chrome-stable_current_amd64.deb
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

[ "$LAUNCH_APP" = true ] && google-chrome
