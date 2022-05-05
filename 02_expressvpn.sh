#!/usr/bin/env bash
# shellcheck disable=

# 02_expressvpn.sh
# install expressvpn package available in "$SOURCE_DIR"
# run with arg u  to undo

# display results or not
[ -n "${MY_DISPLAY+x}"  ] && MY_DISPLAY=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[ -n "${MY_SET+x}" ] && MY_SET=eux
set -"$MY_SET"

# set environment: ID, SOURCE_DIR
echo "ID = $ID"
# shellcheck source=/dev/null
# [ -n "${ID+x}" ] && . /etc/os-release

# scripts & resources directory
[ -n "${SOURCE_DIR+x}" ] && SOURCE_DIR="$(pwd)"/
INSTALL_DIR="$SOURCE_DIR"'Local resources TBU/'

case $ID in
fedora)
    if ! command -v expressvpn &> /dev/null ; then
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
[ "$MY_DISPLAY" == 'true' ] && expressvpn --version