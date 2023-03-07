#!/usr/bin/env bash
# shellcheck disable=

# ,google-chrome_update.sh
# install or update google-chrome on Linux

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ -n ${ID+foo} ]] || . /etc/os-release

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
    # PKG_FMT='.rpm'
    # PKG_MGR='dnf'
    wget -P /tmp/ https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    sudo dnf install /tmp/google-chrome-stable_current_x86_64.rpm
    ;;
linuxmint | ubuntu)
    # PKG_FMT='.deb'
    # PKG_MGR='apt'
    wget -P /tmp/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install /tmp/google-chrome-stable_current_amd64.deb
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

[ "$LAUNCH_APP" = true ] && google-chrome
