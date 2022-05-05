#!/usr/bin/env bash
# shellcheck disable=

# 00_model.sh
# repeat description of what the script should do
# run with arg u  to undo

# launch after install
[[ ${LAUNCH_APP} ]] || LAUNCH_APP=true

# info verbose debug trace
[[ $MY_TRACE ]] || MY_TRACE=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ ${MY_ENV} ]] || MY_ENV=eux
set -"$MY_ENV"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ ${ID+x} ]] || . /etc/os-release

# scripts & resources directory
[[ ${SOURCE_DIR} ]]  || SOURCE_DIR="$(pwd)"/

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
