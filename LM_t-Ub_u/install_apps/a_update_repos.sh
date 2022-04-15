#!/usr/bin/env bash
# shellcheck disable=

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
export RESOURCES="$HOME/Documents/Github/Local resources TBU/"
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
    if [ ! -d "$repo" ] || [ ! -e "$repo" ]; then
        rm -rv "$repo"
        ! git clone 'https://github.com/ahjun001/'"$repo" && exit 1
    else
        cd "$repo"  || exit 1
        ! git fetch 'https://github.com/ahjun001/'"$repo" && exit 1
        ! git pull 'https://github.com/ahjun001/'"$repo" && exit 1
        cd ..
    fi
done
cd "$old_pwd" || exit 1

printf "\n\n\nExiting $0 ...\n"
