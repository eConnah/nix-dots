#!/usr/bin/env bash

LOCKFILE="/tmp/autoclicker_active"

if [ -f "$LOCKFILE" ]; then
    # If the lockfile exists, remove it to stop the clicking
    rm "$LOCKFILE"
else
    # Create the lockfile and start the loop
    touch "$LOCKFILE"

    while [ -f "$LOCKFILE" ]; do
        # 0xC0 is the hexadecimal code for a left click
        ydotool click 0xC0
    done
fi
