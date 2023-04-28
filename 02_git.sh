#!/usr/bin/env bash

# 02_git.sh
# install git, required to install zsh & oh-my-zsh

set -euo pipefail
IFS=$'\n\t'
# shellcheck source=/dev/null
. ./01_set_env_variables.sh

packageNeeded=git
# Exit if command is already installed
if command -v "$packageNeeded" >>"$INSTALL_LOG"; then
    if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then exit 0; else return 0; fi
fi

case $ID in
fedora)
    sudo dnf install "$packageNeeded"
    ;;
linuxmint | ubuntu)
    sudo apt install "$packageNeeded"
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac
