#!/usr/bin/env bash
# shellcheck disable=

# 00_model.sh
# repeat description of what the script should do
# run with arg u  to undo

# display results or not
[ -n "${MY_DISPLAY+x}" ] && MY_DISPLAY=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[ -n "${MY_SET+x}" ] && MY_SET=eux
set -"$MY_SET"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[ -n "${ID+x}" ] && . /etc/os-release

# scripts & resources directory
[ -n "${SOURCE_DIR+x}" ] && SOURCE_DIR="$(pwd)"/

case $ID in
fedora)
    echo "$0 not implemented in $ID"
    exit 1
    ;;
linuxmint | ubuntu)
    echo "$0 not implemented in $ID"
    exit 1
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

echo " $0 : Exiting ..."
