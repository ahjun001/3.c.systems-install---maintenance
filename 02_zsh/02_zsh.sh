#!/usr/bin/env bash

# 02_zsh.sh
# install zsh & oh-my-zsh

# shellcheck source=/dev/null
. ./01_set_env_variables.sh

# Exit if command is already installed
if command -v zsh >>"$INSTALL_LOG"; then
    if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then exit 0; else return 0; fi
fi

case $ID in
fedora)
    PKG_MGR='dnf'
    ;;
linuxmint | ubuntu)
    PKG_MGR='apt'
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

# zsh and oh-my-zsh

# scripts & resources directory
[[ ${SOURCE_DIR+foo} ]] || SOURCE_DIR="$(pwd)"/

# link to Github .zshrc
my_orig="$SOURCE_DIR/02_zsh/.zshrc"
my_link=/home/perubu/"$(basename "$my_orig")"
if ! ln -fs "$my_orig" "$my_link"; then
    if [ ! -e "${my_link}" ]; then
        exit 1
    fi
    exit 1
fi

# download zsh-vi-mode plugin
git clone https://github.com/jeffreytse/zsh-vi-mode.git "$HOME"/.zsh-vi-mode
# install zsh
sudo "$PKG_MGR" install zsh
# read -r -s -n 1 -p "zsh needs to be run at least once, "
# zsh

# install oh-my-zsh
# OLD_WD=$(pwd)
# cd /tmp || exit 1

# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# chsh -s "$(which zsh)"
# [[ -n ${ZSH_CUSTOM+foo} ]] ||  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
# git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM"/plugins/zsh-vi-mode
# cd "$OLD_WD" || exit 1