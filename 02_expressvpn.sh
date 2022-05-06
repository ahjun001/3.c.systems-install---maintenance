#!/usr/bin/env bash
# shellcheck disable=

# 02_expressvpn.sh
# install expressvpn package available in "$SOURCE_DIR"

# run with arg x to perform, u  to undo; argument is required to comply with set -u
case $# in
0) ACT=x ;; # used when editing modular script
1) case $1 in
    x | u) ACT=$1 ;;
    *) echo "argument when launching $0 should be 'x' or 'u'" && exit 1 ;;
    esac ;;
*) echo "error launching $0 : too many arguments" && exit 1 ;;
esac

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
[[ $MY_TRACE ]] || MY_TRACE=true

# launch after install
[[ -n ${LAUNCH_APP+foo} ]] || LAUNCH_APP=true

INSTALL_DIR="$SOURCE_DIR"'Local resources TBU/'

case $ID in
fedora)
    case $ACT in
    x)
        if command -v expressvpn &>/dev/null; then
            [ "$MY_TRACE" = true ] && echo "expressvpn is already installed, nothing to do"
        else
            if ls "$INSTALL_DIR"'expressvpn'*'.rpm' &>/dev/null; then
                sudo dnf install "$INSTALL_DIR"'expressvpn'*'.rpm'
                expressvpn activate
                expressvpn connect
                sudo dnf update
            fi
        fi
        ;;
    u) sudo dnf remove expressvpn ;;
    *) echo "Should never happen" || exit 1 ;;
    esac
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
[ "$LAUNCH_APP" = true ] && expressvpn --version
