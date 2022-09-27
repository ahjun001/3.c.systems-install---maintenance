#!/usr/bin/env bash
# shellcheck disable=

# 02_mount_data.sh
# mount data partition
# run with arg u  to undo

# launch after install
[[ -n ${LAUNCH_APP+foo} ]] || LAUNCH_APP=true

# info verbose debug trace
[[ ${MY_TRACE+foo} ]] || MY_TRACE=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ -n ${MY_ENV+foo} ]] || MY_ENV=eux
set -"$MY_ENV"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ -n ${ID+foo} ]] || . /etc/os-release

# scripts & resources directory
[[ ${SOURCE_DIR+foo} ]] || SOURCE_DIR="$(pwd)"/

case $ID in
fedora)
    if ! grep -qs /dev/nvme0n1p10 /proc/mounts; then
        MOUNT_DIR=/run/media/perubu/data
        [ ! -d "$MOUNT_DIR" ] && sudo mkdir "$MOUNT_DIR"
        sudo mount /dev/nvme0n1p10 "$MOUNT_DIR"
        echo '/dev/disk/by-label/data /run/media/perubu/data auto nosuid,nodev,nofail,x-gvfs-show 0 0' | sudo tee -a /etc/fstab
    # read -r -n 1 -s -p "plasma-discover to be launched, install gnome-disk, with gnome-disk mount partition data on boot, enter any key to proceed ..."
    # plasma-discover
    fi
    ;;
ubuntu)
    echo "$0 not implemented in $ID"
    exit 1
    ;;
linuxmint)
    echo "$0 not implemented in $ID"
    # exit 1
    ;;
esac

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"
