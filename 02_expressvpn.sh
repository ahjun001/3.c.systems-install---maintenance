#!/usr/bin/env bash
# shellcheck disable=

# 02_expressvpn.sh
# install expressvpn package available in "$SOURCE_DIR"
# run with arg u  to undo

# display results or not
[ -z ${PJ_DISPLAY+x} ] && PJ_DISPLAY=true

# -e to exit on error
# -u to exit on unset variables
# optionnally -x to echo commands
set -eux

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[ -z ${ID+x} ] && . /etc/os-release

# scripts & resources directory
[ -z ${SOURCE_DIR+x} ] && SOURCE_DIR="$(pwd)"/

case $ID in
fedora)
    # if ! command -v expressvpn ; then
        if ls "$SOURCE_DIR"'expressvpn'*'.rpm' &> /dev/null ; then
        sudo dnf install "$SOURCE_DIR"'expressvpn'*'.rpm'
        expressvpn activate
        expressvpn connect
        sudo dnf update
        fi
    # fi
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
