#!/usr/bin/env sh
# shellcheck disable=SC3044

# todo
# create corresponding test
# environment for distro  LxMt Kub WLC
# if shelltest don't provide better view, then loop

# mkdir -p ~/Documents/Github
# cd ~/Documents/Github
# download from https://github.com/ahjun001/3.c.systems-install-n-maintain.git
# install VPN

set -x

sudo apt update

# Vim
if ! command -v vim; then
    if ! ../vim/vim_pj_install.sh; then exit 1; fi
fi
if ! command -v nvim; then
    if ! ../vim/nvim_pj_install.sh; then exit 1; fi
fi

# Firefox
if ! firefox; then exit 1; fi

# VSCode
firefox https://code.visualstudio.com/Download
dpkg -i /tmp/code*.deb
# sign-in to install plugins
if ! "$cli_command"; then exit 1; fi

# shellSpec
cli_command=shellspec
if ! command -v "$cli_command"; then
    pushd /tmp || exit
    if ! wget -O- https://git.io/shellspec | sh; then exit 1; fi
    popd || exit
fi
if ! shellspec -v; then exit 1; fi

# reset links for vim, nvim, zsh, VSCode, shellSpec
if ! sudo ./reset\ all\ links.sh; then exit 1; fi

# python
sudo apt install python3 python3-venv python3-pip

# brave
pushd /tmp || exit 1
sudo apt -y install curl software-properties-common apt-transport-https 
curl https://brave-browser-apt-release.s3.brave.com/brave-core.asc| gpg --dearmor > brave-core.gpg
sudo install -o root -g root -m 644 brave-core.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser
popd

# Chrome
,google-chrome_update.sh
if ! google-chrome; then exit 1; fi

# anki
cli_command=anki
if ! command -v "$cli_command"; then sudo apt install "$cli_command"; fi
if ! "$cli_command"; then exit 1; fi

# thunderbird
cli_command=thunderbird
if ! command -v "$cli_command"; then sudo apt install "$cli_command"; fi
if ! "$cli_command"; then exit 1; fi

# system-monitor
if ! gnome-system-monitor; then exit 1; fi

# inkscape
if ! command -v inkscape; then
    add-apt-repository ppa:inkscape.dev/stable
    sudo apt update
    sudo apt install inkscape
fi
if ! inkscape; then exit 1; fi

# disk usage analyser
if ! baobab; then exit 1; fi

# libre-office
if ! libreoffice --writer; then exit 1; fi

# calculator
if ! gnome-calculator; then exit 1; fi

# VMWare player
if ! vmware-player; then
    ./install_vmware_player.sh
fi

# torrent downloader
if ! transmission-gtk; then exit 1; fi

# webapp manager
echo 'add https://cnrtl.fr/definition/'
echo 'https://www.google.com'
echo 'https://leconjugueur.lefigaro.fr'
echo 'https://trello.com/b/qlpLmRO5/1perso'
echo 'https://web.whatsapp.com/'
echo 'https://www.youtube.com/'
webapp-manager

# audacity
cli_command=audacity
if ! command -v "$cli_command"; then sudo apt install "$cli_command"; fi
if ! "$cli_command"; then exit 1; fi

# screen-shot
if ! gnome-screenshot --interactive; then exit 1; fi

# install wine
sudo dpkg --add-architecture i386
mintinstall

# install wine programs
printf '\nInstall Wenlin, WeChat\n'

set +x
