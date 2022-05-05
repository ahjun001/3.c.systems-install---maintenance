#!/usr/bin/env bash
# shellcheck disable=

# 02_shellspec.sh
# repeat description of what the script should do
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

# shellSpec
cli_command=shellspec
if ! command -v "$cli_command"; then
    oldwd='pwd'
    cd "$RESOURCES" || exit
    if ! wget -O- https://git.io/shellspec | sh; then exit 1; fi
    cd "$oldwd" || exit
fi

echo " $0 : Exiting ..."