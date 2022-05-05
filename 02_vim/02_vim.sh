#!/usr/bin/env bash
# shellcheck disable=

# 02_vim.sh
# install vim on new machine, that is:
# gvim as main editor
# vim-mini as
# run with arg u  to undo

# display results or not
[ -n "${MY_DISPLAY+x}"  ] && MY_DISPLAY=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[ -n "${MY_SET+x}" ] && MY_SET=eux
set -"$MY_SET"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[ -n "${ID+x}" ] && . /etc/os-release

# scripts & resources directory
[ -n "${SOURCE_DIR+x}" ] && SOURCE_DIR="$(pwd)"/

# install gvim if not present yet, and make it default editor
if ! command -v gvim; then
    case $ID in
    fedora)
        sudo dnf install vim-X11
        sudo dnf install vim-default-editor --allowerasing
        ;;
    linuxmint | ubuntu)
        sudo apt install vim.gtk3
        update-alternatives --set editor /usr/bin/vim.gtk3
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

if ! command -v gvim ; then exit 1; fi

echo " $0 : Exiting ..."
