#!/usr/bin/env bash
# shellcheck disable=

# 02_zsh.sh
# install zsh & oh-my-zsh

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ -n ${MY_ENV+foo} ]] || MY_ENV=eux
set -"$MY_ENV"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ -n ${ID+foo} ]]  || . /etc/os-release

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
    [[  ${SOURCE_DIR+foo} ]] || SOURCE_DIR="$(pwd)"/

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
    # OLD_WD=$(pwd)
    # cd /tmp || exit 1

    # sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # chsh -s "$(which zsh)"
    # [[ -n ${ZSH_CUSTOM+foo} ]] ||  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    # git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM"/plugins/zsh-vi-mode
    # cd "$OLD_WD" || exit 1
fi

echo " $0 : Exiting ..."
