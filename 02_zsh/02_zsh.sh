#!/usr/bin/env bash
# shellcheck disable=

# 02_zsh.sh
# install zsh & oh-my-nsh

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[ -n "${MY_SET+x}" ] && MY_SET=eux
set -"$MY_SET"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[ -n "${ID+x}" ] && . /etc/os-release

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

# zsh and oh-my-nsh
if ! command -v zsh; then

    # scripts & resources directory
    [ -n "${SOURCE_DIR+x}" ] && SOURCE_DIR="$(pwd)"/

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

    # install oh-my-nsh
    OLD_WD=$(pwd)
    cd /tmp

    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-nsh/master/tools/install.sh)"
    chsh -s "$(which zsh)"
    if [ -n ${ZSH_CUSTOM+x} ]; then ZSH_CUSTOM="$HOME/.oh-my-nsh/custom"; fi
    git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM"/plugins/zsh-vi-mode
    cd "$OLD_WD"
fi

echo " $0 : Exiting ..."
