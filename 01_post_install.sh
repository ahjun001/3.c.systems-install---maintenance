#!/usr/bin/env bash
# shellcheck disable=

# post install script to install favorite environment, apps, and settings
OPEN_APP=true



# -e to exit on error
# -u to exit on unset variables
# optionnally -x to echo commands
set -eux

# scripts & resources directory
export SOURCE_DIR='/media/perubu/data_ntfs/3.c-install-n-utils/'
# export SOURCE_DIR='/run/media/perubu/data_ntfs/3.c-install-n-utils/'
# export SOURCE_DIR="$HOME/Documents/Github/3.c-install-n-utils/"

# export set environment, mainly ID = linuxmint / ubuntu / fedora
# shellcheck source=/dev/null
. /etc/os-release

# speed up Linux Package Manager
./02_speed_up_dnf_n_apt.sh

# install expressvpn package available in "$SOURCE_DIR"
./02_expressvpn.sh

# modify grub2 to save default, show count down, install theme
./02_grub2.sh

# install vim
./02_vim/02_vim.sh
[ "$OPEN_APP" == 'true' ] && vim

# install nvim
./02_vim/02_nvim.sh
[ "$OPEN_APP" == 'true' ] && nvim

# install vscode
./02_code/02_code.sh
[ "$OPEN_APP" == 'true' ] && code

# install git, required to install zsh & oh-my-zsh
./02_git.sh

# install zsh & oh-my-zsh
./02_zsh/02_zsh.sh

# mount data partition
./02_mount_data.sh

# update repositories, possibly on data partition
./02_update_repos.sh

# reset all links
sudo ./03_reset_all_links.sh

echo "Exiting $0 ..."
