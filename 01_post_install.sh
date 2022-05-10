#!/usr/bin/env bash
# shellcheck disable=

# post install script to install favorite environment, apps, and settings

# export set environment, mainly ID = linuxmint / ubuntu / fedora
# shellcheck source=/dev/null
. /etc/os-release
export ID

# scripts & resources directory
SOURCE_DIR="$(pwd)"/
export SOURCE_DIR

# -e to exit on error
# -u to exit on unset variables
# optionnally -x to echo commands
MY_ENV=eux
export MY_ENV
set -${MY_ENV}

# info verbose debug trace
MY_TRACE=true
export MY_TRACE

# launch apps after install
 LAUNCH_APP=true
 export LAUNCH_APP

# speed up Linux Package Manager
# ./02_speed_up_dnf_n_apt.sh x

# install expressvpn package available in "$SOURCE_DIR"
# ./02_expressvpn.sh x

# modify grub2 to save default, show count down, install theme
# ./02_grub2.sh x

# install vim
./02_vim/02_vim.sh x

# install nvim
./02_vim/02_nvim.sh x

# install vscode
./02_code/02_code.sh x

# install git, required to install zsh & oh-my-zsh
./02_git.sh x

# install zsh & oh-my-zsh
./02_zsh/02_zsh.sh x

# install shellspec
./02_shellspec.sh x

# mount data partition
./02_mount_data.sh x

# update repositories, possibly on data partition
./02_update_repos.sh x

# reset all links
sudo ./03_reset_all_links.sh x

# install google-chrome
,google-chrome_update.sh x

# install brave
./02_brave.sh x

# install nodeJS & npm, pre-requisites for nativefier -- which transforms websites into web apps
./02_npm.sh x

# install natifvefier, transforms websites into web apps
./02_nativefier.sh

# install gimp
./02_gimp.sh x

# install httrack
./02_httrack.sh

echo "Exiting $0 ..."
