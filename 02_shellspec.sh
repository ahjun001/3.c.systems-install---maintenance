#!/usr/bin/env bash
# shellcheck disable=

# 02_shellspec.sh
# repeat description of what the script should do
# run with arg u  to undo

# display results or not
[ -z ${PJ_DISPLAY+x} ] && PJ_DISPLAY=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
set -eu

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[ -z ${ID+x} ] && . /etc/os-release

# scripts & resources directory
[ -z ${SOURCE_DIR+x} ] && SOURCE_DIR="$(pwd)"/

# shellSpec
cli_command=shellspec
if ! command -v "$cli_command"; then
    oldwd='pwd'
    cd "$RESOURCES" || exit
    if ! wget -O- https://git.io/shellspec | sh; then exit 1; fi
    cd "$oldwd" || exit
fi

echo " $0 : Exiting ..."