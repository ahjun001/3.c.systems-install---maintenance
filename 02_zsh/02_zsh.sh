#!/usr/bin/env bash
# shellcheck disable=

# 02_zsh.sh
# install zsh & oh-my-zsh

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for debut purposes
set -eu

# zsh and oh-my-zsh
if ! command -v zsh; then
    # install zsh
    sudo "$PKG_MGR" install zsh
    
    # install oh-my-zsh
    OLD_WD=$(pwd)
    cd /tmp
    
    git clone https://github.com/jeffreytse/zsh-vi-mode i/plugins/zsh-vi-mode "$ZSH_CUSTOM"/plugins/zsh-vi-mode
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    chsh
    cd "$OLD_WD"
fi


echo " $0 : Exiting ..."
