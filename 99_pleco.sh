#!/usr/bin/env bash

cd /opt/android-studio/bin && ./studio.sh &
echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"