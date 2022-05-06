#!/usr/bin/env bash
# shellcheck disable=

# 02_git.sh
# install git, required to install zsh & oh-my-zsh
# run with arg u  to undo

# launch after install
[[ -n ${LAUNCH_APP+foo} ]]  || LAUNCH_APP=true

# info verbose debug trace
[[ ${MY_TRACE+foo} ]] || MY_TRACE=true


# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ -n ${MY_ENV+foo} ]] || MY_ENV=eux
set -"$MY_ENV"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ -n ${ID+foo} ]]  || . /etc/os-release

# scripts & resources directory
[[  ${SOURCE_DIR+foo} ]] || SOURCE_DIR="$(pwd)"/

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