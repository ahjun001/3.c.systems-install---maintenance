#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'
# shellcheck source=/dev/null
. ./01_set_env_variables.sh

# 02_expressvpn.sh
# install expressvpn package available in "$SOURCE_DIR"

# Exit if command is already installed
if command -v expressvpn >>"$INSTALL_LOG"; then
    if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then exit 0; else return 0; fi
fi

case $ID in
fedora)
    if command -v expressvpn &>/dev/null; then
        [ "$MY_TRACE" = true ] && echo "expressvpn is already installed, nothing to do"
    else
        if ls "$INSTALL_DIR"'expressvpn'*'.rpm' &>/dev/null; then
            sudo dnf install "$INSTALL_DIR"'expressvpn'*'.rpm'
            expressvpn activate
            expressvpn connect
            sudo dnf update
        fi
    fi
    ;;
linuxmint | ubuntu)
    echo "$0 not implemented in $ID"
    # exit 1
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;

esac

[ "$LAUNCH_APP" = true ] && expressvpn --version
