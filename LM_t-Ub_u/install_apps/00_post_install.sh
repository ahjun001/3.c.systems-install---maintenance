#!/usr/bin/env bash

# setup to install from usb or from local partition
# SOURCE_DIR='/run/media/perubu/data/Local resources TBU/'
SOURCE_DIR='/run/media/perubu/USB STICK/Post-install/Local resources TBU/'

# -e to exit on error, -x to echo commands
set -ex

# shellcheck disable=SC3044

# set environment
# shellcheck source=/dev/null
. /etc/os-release

case $ID in
fedora)
    #dnf flags
    if ! grep -q 'fastestmirror' /etc/dnf/dnf.conf; then
        echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
        echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
        echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
    fi
    less /etc/dnf/dnf.conf

    # install expressvpn package available in "$SOURCE_DIR"
    if ! command -v expressvpn; then
        sudo dnf install "$SOURCE_DIR"'expressvpn'*'.rpm'
        expressvpn activate
        expressvpn connect
    fi
    sudo dnf update

    # modify grub2
    G_FILE=/etc/default/grub
    if ! grep GRUB_SAVEDEFAULT "$G_FILE"; then
        echo GRUB_SAVEDEFAULT=true | sudo tee -a "$G_FILE"

        THEME_DIR=/usr/share/grub/themes/
        [ ! -d "$THEME_DIR"grub2-theme-breeze ] && sudo cp -rv "$SOURCE_DIR"themes/grub2-theme-breeze "$THEME_DIR"
        if ! grep GRUB_THEME "$G_FILE"; then echo GRUB_THEME="/usr/share/grub/themes/grub2-theme-breeze/breeze/theme.txt" | sudo tee -a "$G_FILE"; fi
        less "$G_FILE"
        sudo cp "$G_FILE" "$G_FILE".bak
        sudo rm /boot/efi/EFI/fedora/grub.cfg
        sudo rm /boot/grub2/grub.cfg
        sudo dnf reinstall shim-* grub2-efi-* grub2-common
    fi

    # mount data
    if ! grep -qs /dev/nvme0n1p10 /proc/mounts; then
        MOUNT_DIR=/run/media/perubu/data
        [ ! -d "$MOUNT_DIR" ] && sudo mkdir "$MOUNT_DIR"
        sudo mount /dev/nvme0n1p10 "$MOUNT_DIR"
        echo '/dev/disk/by-label/data /run/media/perubu/data auto nosuid,nodev,nofail,x-gvfs-show 0 0' | sudo tee -a /etc/fstab
    fi
    read -r -n 1 -s -p "plasma-discover to be launched, install gnome-disk, with gnome-disk mount partition data on boot, enter any key to proceed ..." 
    # plasma-discover

    # update repositories on data

    # install vim

    # install nvim

    # install vscode

    ;;

linuxmint)
    PKG_FMT='.rmp'
    PKG_MGR='dnf'
    PKG_FMT='.deb'
    PKG_MGR='apt'
    echo "$PKG_FMT" "$PKG_MGR"
    ;;

*)
    printf "\nPackage format not identified\n\nExiting ..."
    exit 1
    ;;
esac

printf '\n\nExiting %s ...\n' "$0"
