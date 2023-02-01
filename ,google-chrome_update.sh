#!/usr/bin/env bash
# shellcheck disable=

# ,google-chrome_update.sh
# install or update google-chrome on Linux

# run with arg x to perform, u  to undo; argument is required to comply with set -u
# case $# in
# 0) ACT=x ;; # used when editing modular script
# 1) case $1 in
#     x | u) ACT=$1 ;;
#     *) echo "argument when launching $0 should be 'x' or 'u'" && exit 1 ;;
#     esac ;;
# *) echo "error launching $0 : too many arguments" && exit 1 ;;
# esac
#
# Exit if command is already installed
if command -v google-chrome >>/tmp/01_post_install.log; then
    if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then exit 0; else return 0; fi
fi

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

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"
