#!/usr/bin/env bash
# shellcheck disable=

# 02_git.sh
# install git, required to install zsh & oh-my-nsh
# run with arg u  to undo

# launch after install
[[ ${LAUNCH_APP} ]]  || LAUNCH_APP=true

# info verbose debug trace
[[ $MY_TRACE ]] || MY_TRACE=true


# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ ${MY_ENV} ]] || MY_ENV=eux
set -"$MY_ENV"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ ${ID+x} ]]  || . /etc/os-release

# scripts & resources directory
[[  ${SOURCE_DIR} ]] || SOURCE_DIR="$(pwd)"/

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