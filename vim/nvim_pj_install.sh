#!/usr/bin/env sh

# from https://github.com/ahjun001/3.a.1-linux.git

set -x
store_dir=~/Documents/Github/3.c.systems-install-n-maintain/vim/

# install neovim, run nvim

install_dir='/opt/nvim/'
if [ ! -d "$install_dir" ]; then mkdir "$install_dir"; fi

install_file="$install_dir"nvim.appimage
if [ ! -f "$install_file" ]; then
    sudo wget -P "$install_dir" https://github.com/neovim/neovim/releases/latest/download/nvim.appimage 
    # curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o "$install_file"
    chmod u+x "$install_file"
fi

sudo ln -fs "$install_file" /usr/local/bin/nvim

sudo ln -fs "$store_dir"vimrc /usr/share/sysinit.vim
# ln -fs $store_dir/vimrc ~/.config/nvim/init.vim
if ! nvim; then exit; fi

set +x
printf '\nExiting %s\n' "$0"
