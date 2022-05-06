#!/usr/bin/env bash
# shellcheck disable=

# 02_speed_up_dnf_n_apt.sh
# speed up Linux Package Manager

# run with arg x to perform, u  to undo; argument is required to comply with set -u
case $# in
0) ACT=x ;; # used when editing modular script
1) case $1 in
    x | u) ACT=$1 ;;
    *) echo "argument when launching $0 should be 'x' or 'u'" && exit 1 ;;
    esac ;;
*) echo "error launching $0 : too many arguments" && exit 1 ;;
esac

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ -n ${ID+foo} ]] || . /etc/os-release

# scripts & resources directory
[[ -n ${SOURCE_DIR+foo} ]] || SOURCE_DIR="$(pwd)"/

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ -n ${MY_ENV+foo} ]] || MY_ENV=eux
set -"$MY_ENV"

# info verbose debug trace
[[ ${MY_TRACE+foo} ]] || MY_TRACE=true

# launch after install
[[ -n ${LAUNCH_APP+foo} ]] || LAUNCH_APP=true

case $ID in
fedora)
    #dnf flags
    lines=(
        'fastestmirror=1'
        'max_parallel_downloads=10'
        'deltarpm=true'
    )
    for line in "${lines[@]}"; do
        # only delete the line if it exists, and add it if it doesn't exist yet
        if grep -q "$line" /etc/dnf/dnf.conf; then
            if [ "$ACT" = 'u' ]; then
                sudo sed -i "/$line/d" /etc/dnf/dnf.conf
                [ "$MY_TRACE" = true ] && echo "deleted line $line"
            else
                [ "$MY_TRACE" = true ] && echo "$line already in file, nothing done"
            fi
        else
            if [ "$ACT" = 'u' ]; then
                [ "$MY_TRACE" = true ] && echo "$line not found, nothing to be deleted"
            else
                echo "$line" | sudo tee -a /etc/dnf/dnf.conf
                [ "$MY_TRACE" = true ] && echo "added line $line"
            fi
        fi
    done
    [ "$LAUNCH_APP" = true ] && less /etc/dnf/dnf.conf
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

echo -e "\n $0 : Exiting ..."
