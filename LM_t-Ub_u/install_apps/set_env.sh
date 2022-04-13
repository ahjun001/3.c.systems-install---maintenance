#!/usr/bin/env bash

# Mint or Ubuntu

ID=""
OUT="$(grep -h '^ID=' /etc/os-release)"
export ID="${OUT##*=}"

UB_U_CODENAME=""
OUT="$(grep -h 'UBUNTU_CODENAME=' /etc/os-release)"
export UB_U_CODENAME="${OUT##*=}"

# cp /etc/os-release /tmp/os-release
# sed "s/\"/'/g" -i /tmp/os-release
# lines=$(cat /tmp/os-release)
# for line in $lines; do
#     export "${line?}"
# done
