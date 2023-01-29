#!/usr/bin/env bash
# shellcheck disable=

# 02_nvim.sh
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
    echo "$0 not implemented in $ID"
    exit 1
    ;;
linuxmint | ubuntu)
    sudo apt install ~/Downloads/nvim-linux64.deb 
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

mkdir -p ~/.config/nvim/
ln -fs "$SOURCE_DIR"/02_vim/vimrc ~/.config/nvim/init.vim

# echo "ACT = $ACT Should remove this to use the script" && exit 1
echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"
