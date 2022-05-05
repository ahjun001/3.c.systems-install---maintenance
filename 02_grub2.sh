#!/usr/bin/env bash
# shellcheck disable=

# 02_grub2.sh
# modify grub2 to save default, show count down, install theme
# run with arg u  to undo

# launch after install
[[ ${LAUNCH_APP} ]]  || LAUNCH_APP=true

# info verbose debug trace
[[ $MY_TRACE ]] || MY_TRACE=true


# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ ${MY_ENV} ]] || MY_ENV=eux
set -"$MY_ENV"

# set environment: ID, SOURCE_DIR
# shellcheck source=/dev/null
[[ ${ID+x} ]]  || . /etc/os-release

# scripts & resources directory
[[  ${SOURCE_DIR} ]] && SOURCE_DIR="$(pwd)"/

G_MODIFIED=False
G_FILE=/etc/default/grub
sudo cp "$G_FILE" "$G_FILE"."$(date +%H_%M_%S)"

if ! grep GRUB_SAVEDEFAULT "$G_FILE"; then
    echo GRUB_SAVEDEFAULT=true | sudo tee -a "$G_FILE"
    G_MODIFIED=True
fi

if grep '^GRUB_TERMINAL' "$G_FILE"; then
    sudo sed -i '/^GRUB_TERMINAL/s/^/# /' "$G_FILE"
    G_MODIFIED=True
fi

THEME_DIR=/usr/share/grub/themes/
[ ! -d "$THEME_DIR"grub2-theme-breeze ] && sudo cp -r "$SOURCE_DIR"'Local resources TBU/themes/grub2-theme-breeze' "$THEME_DIR"
if ! grep GRUB_THEME "$G_FILE"; then
    echo GRUB_THEME="/usr/share/grub/themes/grub2-theme-breeze/breeze/theme.txt" | sudo tee -a "$G_FILE"
    G_MODIFIED=True
fi

ls /etc/default/grub.*_*_*
read -r -s -n 1 -p "Do housekeeping if needed. Ctrl-C to break or press any one key to continue ..."
less "$G_FILE"
if [ $G_MODIFIED == True ]; then
    case $ID in
    fedora)
        # sudo rm /boot/efi/EFI/fedora/grub.cfg
        # sudo rm /boot/grub2/grub.cfg
        # sudo dnf reinstall shim-* grub2-efi-* grub2-common
        sudo grub2-mkconfig -o /boot/grub2/grub.cfg
        ;;
    linuxmint | ubuntu)
        sudo update-grub
        ;;
    *)
        echo "Distribution $ID not recognized "
        exit 1
        ;;
    esac
fi

echo "$0 : Exiting ..."
