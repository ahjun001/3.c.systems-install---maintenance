#!/usr/bin/env bash
# shellcheck disable=

# 02_update_repos.sh
# update repositories, possibly on data partition

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for debut purposes
set -eu

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
if [ -z ${ID+x} ]; then . /etc/os-release; fi

# scripts & resources directory
if [ -z ${SOURCE_DIR+x} ]; then
    # SOURCE_DIR='/run/media/perubu/data/Local resources TBU/'
    # SOURCE_DIR='/run/media/perubu/USB STICK/3.c-install-n-utils/'
    SOURCE_DIR='/media/perubu/USB STICK/3.c-install-n-utils/'
fi

# ~/Github relevant resources
case $ID in
fedora | ubuntu)
    GITHUB_DIR='/run/media/perubu/data/'
    PART_DIR="$HOME/Documents/Github/"
    [ ! -d "$PART_DIR" ] && mkdir -v "$PART_DIR"

    ;;
linuxmint)
    GITHUB_DIR="$HOME/Documents/Github/"
    exit 1
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac
[ ! -d "$GITHUB_DIR" ] && mkdir -v "$GITHUB_DIR"

old_pwd="$(pwd)"
cd "$GITHUB_DIR" || exit 1

repos=(
    '3.c.systems-install-n-utils'
    '3.a.1-linux'
    '3.a.2-vsCode'
)
for repo in ${repos[0]}; do
    if [ ! -d "$repo" ] || [ ! -e "$repo" ]; then
        rm -rv "$repo"
        ! git clone 'https://github.com/ahjun001/'"$repo" && exit 1
    else
        cd "$repo" || exit 1
        ! git fetch 'https://github.com/ahjun001/'"$repo" && exit 1
        ! git pull 'https://github.com/ahjun001/'"$repo" && exit 1
        cd ..
    fi
done
cd "$old_pwd" || exit 1

# for ThinkBook, make links from Fedora or Kubuntu partition to data
for repo in ${repos[0]}; do
    my_orig="$GITHUB_DIR"repo
    my_link="$PART_DIR"repo
    if ! ln -fs "$my_orig" "$my_link" || [ ! -e "${my_link}" ]; then
        exit 1
    fi
done

echo " $0 : Exiting ..."
