#!/usr/bin/env bash
# shellcheck disable=

# post install script to install favorite environment, apps, and settings
OPEN_APP=true



# -e to exit on error
# -u to exit on unset variables
# optionnally -x to echo commands
set -eux

# scripts & resources directory
# export SOURCE_DIR='/run/media/perubu/data/Local resources TBU/'
export SOURCE_DIR='/run/media/perubu/USB STICK/3.c-install-n-utils/'

# export set environment, mainly ID = linuxmint / ubuntu / fedora
# shellcheck source=/dev/null
. /etc/os-release

# speed up Linux Package Manager
./01_speed_up_dnf_n_apt.sh

# install expressvpn package available in "$SOURCE_DIR"
./01_expressvpn.sh

# modify grub2 to save default, show count down, install theme
./01_grub2.sh

# install vim
./02_vim/02_vim.sh
[ "$OPEN_APP" == 'true' ] && vim

# install nvim
./02_vim/02_nvim.sh
[ "$OPEN_APP" == 'true' ] && nvim

# install vscode
./02_vscode.sh
[ "$OPEN_APP" == 'true' ] && code

# install git, required to install zsh & oh-my-zsh
./02_git.sh

# install zsh & oh-my-zsh
./02_zh/02_zsh.sh

# mount data partition
./02_mount_data

# update repositories, possibly on data partition
./02_update_repos.sh

# reset all links
sudo ./09_reset_all_links.sh

printf '\n\nExiting %s ...\n' "$0"
