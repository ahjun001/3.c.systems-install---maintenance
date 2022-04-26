#!/usr/bin/env bash
# shellcheck disable=

# 00_model.sh
# repeat description of what the script should do

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for debut purposes
set -eu

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
if [ -z ${ID+x} ]; then . /etc/os-release; fi

# scripts & resources directory
if [ -z ${SOURCE_DIR+x} ]; then SOURCE_DIR="$(pwd)"; fi

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
