#!/usr/bin/env bash
set -x
sudo service network-manager restart
echo $?
set +x

echo "$(basename -- "$0") exited with code=$?"