#!/usr/bin/env bash
# shellcheck disable=

# 02_zsh.sh
# install zsh & oh-my-zsh

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for debut purposes
set -eux

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
if [ -z ${ID+x} ]; then . /etc/os-release; fi

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
if ! command -v zsh; then

    # scripts & resources directory
    if [ -z ${SOURCE_DIR+x} ]; then SOURCE_DIR="$(pwd)"/; fi

    # link to Github .zshrc
    my_orig="$SOURCE_DIR/02_zsh/.zshrc"
    my_link=/home/perubu/"$(basename "$my_orig")"
    if ! ln -fs "$my_orig" "$my_link"; then
        if [ ! -e "${my_link}" ]; then
            exit 1
        fi
        exit 1
    fi

    # install zsh
    sudo "$PKG_MGR" install zsh
    # read -r -s -n 1 -p "zsh needs to be run at least once, "
    # zsh

    # install oh-my-zsh
    OLD_WD=$(pwd)
    cd /tmp

    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    chsh -s "$(which zsh)"
    if [ -z ${ZSH_CUSTOM+x} ]; then ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"; fi
    git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM"/plugins/zsh-vi-mode
    cd "$OLD_WD"
fi

echo " $0 : Exiting ..."
