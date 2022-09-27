#!/usr/bin/env bash

# /usr/local/sbin/_restore_minimized_wins.sh

# Restore mimimized windows in workspace
# depends on xdotool (apt install xdotool) and wmctrl (apt install wmctrl)

WORKSPACE=$(xdotool get_desktop)
WINDOWS=$(wmctrl -l | awk "/ $WORKSPACE /" | cut -f1 -d' ')
for i in $WINDOWS; do wmctrl -ia "$i"; done

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"