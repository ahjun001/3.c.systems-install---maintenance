#!/usr/bin/env bash
# shellcheck disable=SC3044

# manually install and run VPN, manually install if not present
if ! command -v expressvpn; then
    exit 1
fi
while ! expressvpn status | grep Connected; do
    expressvpn connect smart
done

# run
set -x

# set environment
./set_env.sh
# check if needed
# ./list_env.sh

# Set local resources directory, if doesn't exist, script will later attempt to download them in
RESOURCES="$HOME/Documents/Local resources TBU/"
[ ! -d "$RESOURCES" ] && mkdir -v "$RESOURCES"
# for machine with only 1 distro    in ~/Documents/Github
# or for multi distros              in DATA partition  and then create links to ~/Documents/Github

# Get resources for reset\ all\ links.sh

packageNeeded=git
if ! command -v "$packageNeeded"; then
    if [ -x "$(command -v apt)" ]; then
        sudo apt install "$packageNeeded"
    elif [ -x "$(command -v dnf)" ]; then
        sudo dnf install "$packageNeeded"
    else
        echo "Package manager not supported"
        exit 1
    fi
fi

# ~/Github relevant resources
GITHUB_DIR="$HOME/Documents/Github/"
[ ! -d "$GITHUB_DIR" ] && mkdir -v "$GITHUB_DIR"

old_pwd="$(pwd)"
cd "$GITHUB_DIR" || exit 1

for repo in \
    '3.c.systems-install-n-maintain' \
    '3.a.1-linux' \
    '3.a.2-vsCode'; do
    if [ ! -d "$GITHUB_DIR""$repo" ] || [ ! -e "$GITHUB_DIR""$repo" ]; then
        rm -rv "$repo"
        git clone 'https://github.com/ahjun001/'"$repo"
    fi
done
cd "$old_pwd" || exit 1

set +x && exit
# create a bash script to launch installed apps afterwards, pin to panel, install plugins if needed
printf "#!/usr/bin/env bash\n\nprintf 'Launch apps that have been previously installed\nPin to panel\nInstall plugins if needed'\n\n" >./check_n_pin.sh
chmod +x check_n_pin.sh

# VSCode
if ! command -v code; then
    while ! ls "${RESOURCES}"'code'*'.deb' 1>/dev/null 2>&1; do
        read -r -n 1 -s -p "Set firefox about:preferences Downloads to 'Always ask where to save files'

        Save in ${RESOURCES}
        
        Press any key to continue ..."
        firefox https://code.visualstudio.com/Download
    done
    find "${RESOURCES}" -maxdepth 1 -name "code*.deb" -print0 | xargs -0 -I{} sudo apt install {}
else
    printf 'echo "sign-in to install plugins"\ncode' >>./check_n_pin.sh
fi
exit

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

# todo
# create corresponding test
# environment for distro  LxMt Kub WLC
# if shelltest don't provide better view, then loop

# mkdir -p ~/Documents/Github
# cd ~/Documents/Github

# create check_n_pin.sh as apps are installed
# group apps
# install difficult first and create a backup
