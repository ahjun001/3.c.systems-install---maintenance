#!/usr/bin/env sh

unset ID UBUNTU_CODENAME

# shellcheck source=/dev/null
. /etc/os-release

echo "$0 :"'ID = '"$ID"
echo 'UBUNTU_CODENAME = '"$UBUNTU_CODENAME"