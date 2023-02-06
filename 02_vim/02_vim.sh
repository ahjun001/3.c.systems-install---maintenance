#!/usr/bin/env bash

# 02_vim.sh
# install vim on new machine, that is:
# gvim as main editor
# vim-mini as
# run with arg u  to undo

set -euo pipefail
IFS=$'\n\t'
# shellcheck source=/dev/null
. ./01_set_env_variables.sh

# Exit if command is already installed
if command -v gvim >>"$INSTALL_LOG"; then
    if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then exit 0; else return 0; fi
fi

# install gvim if not present yet, and make it default editor
case $ID in
fedora)
    sudo dnf install vim-X11
    sudo dnf install vim-default-editor --allowerasing
    ;;
linuxmint | ubuntu)
    sudo apt install vim-gtk3
    # update-alternatives --set editor /usr/bin/vim
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

# install directories and vimrc environment
for vim_dir in backup swap undo view; do
    mkdir -p ~/.vim/$vim_dir
done

ln -fs "$SOURCE_DIR"/02_vim/vimrc ~/.vim/vimrc

if ! command -v gvim; then exit 1; fi
