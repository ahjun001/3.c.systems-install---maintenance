#!/usr/bin/env bash
# shellcheck disable=

# 00_nvim.sh
# install nvim after vim has been installed
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

# install neovim, run nvim

if ! command -v nvim; then
    install_dir='/opt/nvim/'
    if [ ! -d "$install_dir" ]; then
        sudo mkdir -p "$install_dir"
        sudo chown perubu:perubu "$install_dir"
    fi

    install_file="$install_dir"nvim.appimage
    if [ ! -f "$install_file" ]; then
        sudo wget -P "$install_dir" https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
        # curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o "$install_file"
        sudo chmod +x "$install_file" || exit 1
    fi

    sudo ln -fs "$install_file" /usr/local/bin/nvim

    sudo ln -fs "$SOURCE_DIR"/02_vim/vimrc /usr/share/sysinit.vim
fi

if ! command -v nvim; then exit 1; fi

echo " $0 : Exiting ..."
