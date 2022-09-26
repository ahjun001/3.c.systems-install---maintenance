#!/usr/bin/env bash
set -x
expressvpn connect smart
set +x

echo "$(basename -- "$0") exited with code=$?"