#!/usr/bin/env bash
# shellcheck disable=

# 02_expressvpn.sh
# install expressvpn package available in "$SOURCE_DIR"

# -e to exit on error
# -u to exit on unset variables
# optionnally -x to echo commands
set -eu

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
if [ -z ${ID+x} ]; then . /etc/os-release; fi

# scripts & resources directory
if [ -z ${SOURCE_DIR+x} ]; then SOURCE_DIR="$(pwd)"; fi

case $ID in
fedora)
    if ! command -v expressvpn; then
        sudo dnf install "$SOURCE_DIR"'expressvpn'*'.rpm'
        expressvpn activate
        expressvpn connect
        sudo dnf update
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
