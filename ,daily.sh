#!/usr/bin/env bash

clear
set -eux
expressvpn status
cat <<EOF


EOF
,width_reduce.sh &
cat <<EOF


EOF

# set environment: ID
# shellcheck source=/dev/null
[[ -n ${ID+foo} ]] || . /etc/os-release

case $ID in
fedora) sudo dnf -y update ;;
linuxmint | ubuntu) sudo apt update -y && sudo apt upgrade -y ;;
*) echo "Should not happen" && exit 1 ;;
esac
cat <<EOF


EOF
case $ID in
linuxmint | ubuntu) sudo yt-dlp -U ;;
fedora) ;;
*) echo "Should not happen" && exit 1 ;;
esac

echo "$(basename -- "$0") exited with code=$?"