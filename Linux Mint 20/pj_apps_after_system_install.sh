#!/usr/bin/env sh

# todo
# pass any # of args
# create corresponding test
# environment for distro  LxMt Kub WLC
# if shelltest don't provide better view, then loop

# download from github

set -x

apt update

# Vim
../vim/vim_pj_install.sh

# Firefox
apt install firefox "$1"
if ! firefox; then exit; fi 

# Chrome
,google-chrome_update.sh "$1"
if ! google-chrome; then exit; fi

# VSCode
apt install code "$1"
# sign-in to install plugins
if ! code; then exit; fi

# anki
apt install anki "$1"
if ! anki; then exit; fi

# thunderbird
apt install thunderbird "$1"
if ! thunderbird; then exit; fi

# system-monitor
if ! gnome-system-monitor; then exit; fi

# inkscape
add-apt-repository ppa:inkscape.dev/stable
apt update
apt install inkscape
if ! inkscape; then exit; fi

# disk usage analyser
if ! baobab; then exit; fi

# libre-office
if ! libreoffice --writer; then exit; fi

set +x
