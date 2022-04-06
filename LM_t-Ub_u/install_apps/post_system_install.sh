#!/usr/bin/env bash
# shellcheck disable=SC3044

# todo
# create corresponding test
# environment for distro  LxMt Kub WLC
# if shelltest don't provide better view, then loop

# mkdir -p ~/Documents/Github
# cd ~/Documents/Github

# download from https://github.com/ahjun001/3.c.systems-install-n-maintain.git
# download from https://github.com/ahjun001/3.a.1-linux
# download from https://github.com/ahjun001/3.a.2-vscode

# install and run VPN

# create check_n_pin.sh as apps are installed
# group apps
# install difficult first and create a backup

set -x

# using mintinstall

[ -f ./check_n_pin.sh ] && rm ./check_n_pin.sh

# wine wechat, wenlin, iexplorer
if ! command -v wine; then
    timeshift --create --comments "before wine install"
    if ! ./wine_install.sh; then
        exit
    fi
else
    echo 'winecfg' >>./check_n_pin.sh
fi

# vim
if ! command -v vim; then
    if ! ../vim/vim_pj_install.sh; then exit 1; fi
else
    echo 'vim' >>./check_n_pin.sh
fi

# nvim
if ! command -v nvim; then
    if ! ../vim/nvim_pj_install.sh; then exit 1; fi
else
    echo 'vim' >>./check_n_pin.sh
fi

# zsh and oh-my-zsh
if ! command -v zsh; then
    sudo apt install zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    chsh
fi

# VSCode
if ! command -v code; then
    firefox https://code.visualstudio.com/Download
else
    # sign-in to install plugins
    echo 'code' >>./check_n_pin.sh
fi

# shellSpec
cli_command=shellspec
if ! command -v "$cli_command"; then
    oldwd='pwd'
    cd /tmp/ || exit
    if ! wget -O- https://git.io/shellspec | sh; then exit 1; fi
    cd "$oldwd" || exit
else
    echo "shellspec -v" >>./check_n_pin.sh
fi

# reset links for vim, nvim, zsh, VSCode, shellSpec
if ! sudo ./reset\ all\ links.sh; then exit 1; fi

# python
sudo apt install python3 python3-venv python3-pip

# brave
if ! command -v brave-browser; then
    old_wd=$(pwd)
    cd /tmp || exit 1
    sudo apt -y install curl software-properties-common apt-transport-https
    curl https://brave-browser-apt-release.s3.brave.com/brave-core.asc | gpg --dearmor >brave-core.gpg
    sudo install -o root -g root -m 644 brave-core.gpg /etc/apt/trusted.gpg.d/
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
    cd "$old_wd" || exit 1
else
    echo 'brave-browser' >>./check_n_pin.sh
fi

# Chrome
if ! command -v google-chrome; then
    ,google-chrome_update.sh
else
    echo 'google-chrome' >>./check_n_pin.sh
fi

# inkscape
if ! command -v inkscape; then
    add-apt-repository ppa:inkscape.dev/stable
    sudo apt update
    sudo apt install inkscape
else
    echo "inkscape" >>./check_n_pin.sh
fi

# VMWare player
if ! vmware-player; then
    ./install_vmware_player.sh
fi

# webapp manager
echo 'add https://cnrtl.fr/definition/'
echo 'https://www.google.com'
echo 'https://leconjugueur.lefigaro.fr'
echo 'https://trello.com/b/qlpLmRO5/1perso'
echo 'https://web.whatsapp.com/'
echo 'https://www.youtube.com/'
webapp-manager

# anki, audacity
for cli_command in 'anki' 'audacity'; do
    if ! command -v "$cli_command"; then
        sudo apt install "$cli_command"
    else
        printf '%s' "$cli_command" >>check_n_pin.sh
    fi
done

printf """
thunderbird
transmission-gtk
baobab
libreoffice --writer
gnome-calculator
gnome-system-monitor
gnome-screenshot --interactive
""" >>check_n_pin.sh

set +x
