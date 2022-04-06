#!/usr/bin/env bash

# Mint or Ubuntu

export ID=""
OUT="$(grep -h '^ID=' /etc/os-release)"
export ID="${OUT##*=}"

export UB_U_CODENAME=""
OUT="$(grep -h 'UBUNTU_CODENAME=' /etc/os-release)"
export UB_U_CODENAME="${OUT##*=}"