#!/usr/bin/env bash

# 02_mount_data.sh
# mount data partition

# shellcheck source=/dev/null
. ./01_set_env_variables.sh

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
ubuntu | linuxmint)
    echo "$0 not implemented in $ID"
    exit 0
    ;;
esac
