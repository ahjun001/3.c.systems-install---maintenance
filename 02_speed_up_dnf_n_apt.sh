#!/usr/bin/env bash
# shellcheck disable=

# 02_speed_up_dnf_n_apt.sh
# speed up Linux Package Manager

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for debut purposes
set -eu

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
if [ -z ${ID+x} ]; then . /etc/os-release; fi

case $ID in
fedora)
    #dnf flags
    if ! grep -q 'fastestmirror' /etc/dnf/dnf.conf; then
        echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
        echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
        echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
    fi
    less /etc/dnf/dnf.con
    ;;
linuxmint | ubuntu)
    echo "$0 not implemented in $ID"
    # exit 1
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

echo " $0 : Exiting ..."
