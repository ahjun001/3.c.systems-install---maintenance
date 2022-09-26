#!/usr/bin/env bash
set -x
expressvpn disconnect
set +x

echo "$(basename -- "$0") exited with code=$?"