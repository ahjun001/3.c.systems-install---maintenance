#!/usr/bin/env bash
set -x
expressvpn connect smart
set +x

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"