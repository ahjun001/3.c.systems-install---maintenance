#!/usr/bin/env bash
# shellcheck disable=

# 00_model.sh
# repeat description of what the script should do

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for debut purposes
set -eux

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
if [ -z ${ID+x} ]; then . /etc/os-release; fi

# scripts & resources directory
if [ -z ${SOURCE_DIR+x} ]; then SOURCE_DIR="$(pwd)"; fi
LOCAL_RES_DIR="$SOURCE_DIR"'Local resources TBU/'

# if ! command -v code; then
case $ID in
fedora)
    PKG_FMT='rpm'
    PKG_MGR='dnf'
    MY_TERM_COMMAND='konsole'
    MY_FLAGS=' -e '
    ;;
linuxmint | ubuntu)
    PKG_FMT='deb'
    PKG_MGR='apt'
    MY_TERM_COMMAND='gnome-terminal -x '
    MY_FLAGS=' -x '
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

ls "$LOCAL_RES_DIR"code*."$PKG_FMT" &>/dev/null || (
    read -r -n 1 -s -p "Set firefox about:preferences Downloads to 'Always ask where to save files'

Save in ${LOCAL_RES_DIR}

    
Press any key to continue ..." &&
        "$MY_TERM_COMMAND $MY_FLAGS" firefox https://code.visualstudio.com/Download
)

CODE_FILE=$(ls "$LOCAL_RES_DIR"code*."$PKG_FMT") && sudo "$PKG_MGR" install "$CODE_FILE"
# fi

echo " $0 : Exiting ..."
