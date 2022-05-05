#!/usr/bin/env bash
# shellcheck disable=

# 02_speed_up_dnf_n_apt.sh
# speed up Linux Package Manager
# run with arg u  to undo

# display results or not
[ -n "${MY_DISPLAY+x}"  ] && MY_DISPLAY=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[ -n "${MY_SET+x}" ] && MY_SET=eux
set -"$MY_SET"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[ -n "${ID+x}" ] && . /etc/os-release

case $ID in
fedora)
    #dnf flags
    lines=(
        'fastestmirror=1'
        'max_parallel_downloads=10'
        'deltarpm=true'
    )
    for line in "${lines[@]}"; do
        if grep -q "$line" ./dnf.conf; then
            if [ "$1" = 'u' ]; then
                sed -i "/$line/d" ./dnf.conf
                [ "$MY_DISPLAY" == 'true' ] && echo "delete line $line"
            else
                [ "$MY_DISPLAY" == 'true' ] && echo "nothing done"
            fi
        else
            if [ "$1" == 'u' ]; then
                [ "$MY_DISPLAY" == 'true' ] && echo "nothing done"
            else
                echo "$line" | sudo tee -a ./dnf.conf
                [ "$MY_DISPLAY" == 'true' ] && echo "added line $line"
            fi
        fi
    done
    #     echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
    #     echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
    # fi
    # [ "$MY_DISPLAY" == 'true' ] && less ./dnf.conf; fi
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
