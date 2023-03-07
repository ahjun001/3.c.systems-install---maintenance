#!/usr/bin/env bash
# shellcheck disable=

# 02_vim.sh
# install vim on new machine, that is:
# gvim as main editor
# vim-mini as
# run with arg u  to undo

# launch after install
[[ -n ${LAUNCH_APP+foo} ]]  || LAUNCH_APP=true

# info verbose debug trace
[[ ${MY_TRACE+foo} ]] || MY_TRACE=true


# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ -n ${MY_ENV+foo} ]] || MY_ENV=eux
set -"$MY_ENV"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ -n ${ID+foo} ]]  || . /etc/os-release

# scripts & resources directory
[[  ${SOURCE_DIR+foo} ]] || SOURCE_DIR="$(pwd)"/

# install gvim if not present yet, and make it default editor
if ! command -v gvim; then
    case $ID in
    fedora)
        sudo dnf install vim-X11
        sudo dnf install vim-default-editor --allowerasing
        ;;
    linuxmint | ubuntu)
        sudo apt install vim
        # update-alternatives --set editor /usr/bin/vim
        ;;
    *)
        echo "Distribution $ID not recognized, exiting ..."
        exit 1
        ;;
    esac
fi

# install directories and vimrc environment
for vim_dir in backup swap undo view; do
    mkdir -p ~/.vim/$vim_dir
done

ln -fs "$SOURCE_DIR"/02_vim/vimrc ~/.vim/vimrc

if ! command -v vim ; then exit 1; fi

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"
