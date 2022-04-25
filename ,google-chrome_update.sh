#!/usr/bin/env bash

clear
set -x
wget -P /tmp/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install /tmp/google-chrome-stable_current_amd64.deb
set +x
