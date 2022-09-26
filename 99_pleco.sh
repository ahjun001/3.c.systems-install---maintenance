#!/usr/bin/env bash

cd /opt/android-studio/bin && ./studio.sh &
echo "$(basename -- "$0") exited with code=$?"