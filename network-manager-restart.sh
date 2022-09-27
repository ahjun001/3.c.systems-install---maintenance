#!/usr/bin/env bash
set -x
sudo service network-manager restart
echo $?
set +x

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"