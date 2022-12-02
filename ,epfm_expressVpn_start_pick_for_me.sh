#!/usr/bin/env bash
set -eux
expressvpn connect 'Pick for Me'
set +eux

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"