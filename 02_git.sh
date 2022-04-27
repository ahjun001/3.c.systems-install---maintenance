#!/usr/bin/env bash
# shellcheck disable=

# 02_git.sh
# install git, required to install zsh & oh-my-zsh
# run with arg u  to undo

# display results or not
[ -z ${MY_DISPLAY+x} ] && MY_DISPLAY=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
set -eu

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[ -z ${ID+x} ] && . /etc/os-release

# scripts & resources directory
[ -z ${SOURCE_DIR+x} ] && SOURCE_DIR="$(pwd)"/

packageNeeded=git
case $ID in
fedora)
    sudo dnf install "$packageNeeded"
    ;;
linuxmint | ubuntu)
    sudo apt install  "$packageNeeded"
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

echo " $0 : Exiting ..."