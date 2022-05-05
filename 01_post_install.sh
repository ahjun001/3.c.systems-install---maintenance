#!/usr/bin/env bash
# shellcheck disable=

# post install script to install favorite environment, apps, and settings
OPEN_APP=true

# run silently
 LAUNCH_APP=false
 export LAUNCH_APP

# -e to exit on error
# -u to exit on unset variables
# optionnally -x to echo commands
MY_ENV=eux
export MY_ENV
set -${MY_ENV}

# scripts & resources directory
SOURCE_DIR="$(pwd)"/
export SOURCE_DIR

# export set environment, mainly ID = linuxmint / ubuntu / fedora
# shellcheck source=/dev/null
. /etc/os-release
echo "ID = $ID"
export ID

# speed up Linux Package Manager
# ./02_speed_up_dnf_n_apt.sh x

# install expressvpn package available in "$SOURCE_DIR"
./02_expressvpn.sh x
exit
# modify grub2 to save default, show count down, install theme
./02_grub2.sh x

# install vim
./02_vim/02_vim.sh x
[ "$OPEN_APP" == 'true' ] && vim

# install nvim
./02_vim/02_nvim.sh x
[ "$OPEN_APP" == 'true' ] && nvim

# install vscode
./02_code/02_code.sh x
[ "$OPEN_APP" == 'true' ] && code

# install git, required to install zsh & oh-my-nsh
./02_git.sh x

# install zsh & oh-my-nsh
./02_zsh/02_zsh.sh x

# install shellspec
./02_shellspec.sh x

# mount data partition
./02_mount_data.sh x

# update repositories, possibly on data partition
./02_update_repos.sh x

# reset all links
sudo ./03_reset_all_links.sh x

echo "Exiting $0 ..."
