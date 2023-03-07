#!/usr/bin/env bash
# shellcheck disable=

# 02_brave.sh
# repeat description of what the script should do

# run with arg x to perform, u  to undo; argument is required to comply with set -u
# case $# in
# 0) ACT=x ;; # used when editing modular script
# 1) case $1 in
#     x | u) ACT=$1 ;;
#     *) echo "argument when launching $0 should be 'x' or 'u'" && exit 1 ;;
#     esac ;;
# *) echo "error launching $0 : too many arguments" && exit 1 ;;
# esac

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ -n ${ID+foo} ]] || . /etc/os-release

# scripts & resources directory
[[ -n ${SOURCE_DIR+foo} ]] || SOURCE_DIR="$(pwd)"/

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ -n ${MY_ENV+foo} ]] || MY_ENV=eux
set -"$MY_ENV"

# info verbose debug trace
[[ ${MY_TRACE+foo} ]] || MY_TRACE=true

# launch after install
[[ -n ${LAUNCH_APP+foo} ]] || LAUNCH_APP=true

case $ID in
fedora)
    sudo dnf install dnf-plugins-core

    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/

    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

    sudo dnf install brave-browser
    ;;
linuxmint | ubuntu)

    sudo apt update

    sudo apt install curl

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install brave-browser

    ;;

*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

[[ $LAUNCH_APP = true ]] && brave-browser

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"
