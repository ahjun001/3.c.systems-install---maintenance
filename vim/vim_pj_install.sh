#!/usr/bin/env bash

# from https://github.com/ahjun001/3.a.1-linux.git


# shellcheck source=/dev/null
. /etc/os-release

set -x
store_dir=~/Documents/Github/3.c.systems-install-n-maintain/vim

# install vim


case $ID in
linuxmint)
    sudo apt install vim-gtk3
    ;;
fedora)
    sudo dnf install vim-X11
    dnf install -y vim-default-editor --allowerasing
    ;;
*)
    printf "\nPackage format not identified\n\nExiting ..."
    exit 1
    ;;
esac



for vim_dir in backup swap undo view; do
    mkdir -p ~/.vim/$vim_dir
done
ln -fs $store_dir/vimrc ~/.vim/vimrc
# pin to Panel, check, & close
if ! gvim; then exit; fi

# todo
# vim-tiny?
# lien editor"

set +x
printf '\nExiting %s\n' "$0"