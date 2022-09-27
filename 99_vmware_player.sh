#!/usr/bin/env bash

set -x

input_file=https://www.vmware.com/go/getplayer-linux
output_file=/tmp/VMware-Player-Full-xxx.x86_64.bundle
if wget "$input_file" -o "$output_file"; then
    printf '%s downloaded\n' "$input_file"
else
    exit 1
fi
chmod +x "$output_file"
if sudo "$output_file" --required --eulas-agreed; then
    printf 'vmware player successfully installed'
else
    exit 1
fi

set +x
printf 'Exiting %s' "$0"
echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"