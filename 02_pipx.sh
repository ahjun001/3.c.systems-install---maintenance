#!/usr/bin/env bash

# 02_pipx.sh
# repeat description of what the script should do

# shellcheck source=/dev/null
. ./01_set_env_variables.sh

# Exit if command is already installed
if command -v pipx >>"$INSTALL_LOG"; then
    if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then exit 0; else return 0; fi
fi

case $ID in
fedora)
    sudo dnf install pipx
    ;;
linuxmint | ubuntu)
    sudo apt install pipx
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac
