#!/usr/bin/env bash
# shellcheck disable=

# 02_mount_data.sh
# mount data partition

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for debut purposes
set -eu

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
if [ -z ${ID+x} ]; then . /etc/os-release; fi

# scripts & resources directory
if [ -z ${SOURCE_DIR+x} ]; then SOURCE_DIR="$(pwd)"/; fi

case $ID in
fedora)
    if ! grep -qs /dev/nvme0n1p10 /proc/mounts; then
        MOUNT_DIR=/run/media/perubu/data
        [ ! -d "$MOUNT_DIR" ] && sudo mkdir "$MOUNT_DIR"
        sudo mount /dev/nvme0n1p10 "$MOUNT_DIR"
        echo '/dev/disk/by-label/data /run/media/perubu/data auto nosuid,nodev,nofail,x-gvfs-show 0 0' | sudo tee -a /etc/fstab
    fi
    read -r -n 1 -s -p "plasma-discover to be launched, install gnome-disk, with gnome-disk mount partition data on boot, enter any key to proceed ..."
    # plasma-discover
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

echo " $0 : Exiting ..."
