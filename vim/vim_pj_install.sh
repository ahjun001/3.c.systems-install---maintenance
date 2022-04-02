#!/usr/bin/env sh

# from https://github.com/ahjun001/

apt install vim-gtk3
apt install neovim
for vim_dir in backup swap undo view; do
    mkdir -p ~/.vim/$vim_dir
done
# pin to Panel, check, & close
if ! gvim; then exit; fi
if ! nvim; then exit; fi
# vim-tiny?
# lien editor"
