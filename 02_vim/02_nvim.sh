#!/usr/bin/env bash
# shellcheck disable=

# 00_nvim.sh
# install nvim after vim has been installed
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

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"
