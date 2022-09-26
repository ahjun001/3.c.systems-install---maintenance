#!/usr/bin/env bash
# shellcheck disable=

# 02_shellspec.sh
# wher

# launch after install
[[ -n ${LAUNCH_APP+foo} ]] || LAUNCH_APP=true

# info verbose debug trace
[[ ${MY_TRACE+foo} ]] || MY_TRACE=true

# scripts & resources directory
[[ -n ${SOURCE_DIR+foo} ]] || SOURCE_DIR="$(pwd)"/

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ -n ${MY_ENV+foo} ]] || MY_ENV=eux
set -"$MY_ENV"

# shellSpec

cli_command=shellspec
if ! command -v "$cli_command"; then
    cd /tmp || exit
    if ! wget -O - https://git.io/shellspec | sh; then exit 1; fi
    cd "$SOURCE_DIR" || exit
fi

echo "$(basename -- "$0") exited with code=$?"
