#!/usr/bin/env sh

unset ID UBUNTU_CODENAME

# shellcheck source=/dev/null
. ./set_env.sh

echo 'ID = '"$ID"
echo 'UBUNTU_CODENAME = '"$UBUNTU_CODENAME"