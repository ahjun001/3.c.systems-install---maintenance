#!/usr/bin/env bash
# shellcheck disable=

# 02_nativefier.sh
# install nativefier, transforms websites into web apps

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

sudo npm install nativefier -g

[[ $LAUNCH_APP = true ]] && (cd /tmp || exit) && nativefier -p linux -a x64 \
    -u 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Brave Chrome/89.0.4389.72 Safari/537.36' \
    https://youtube.com

[[ $LAUNCH_APP = true ]] && /tmp/YouTube-linux-x64/YouTube

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"
