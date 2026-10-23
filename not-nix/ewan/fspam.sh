#!/usr/bin/env bash

LOCKFILE="/tmp/fspam_active"

if [ -f "$LOCKFILE" ]; then
  # If the lockfile exists, remove it to stop the clicking
  rm "$LOCKFILE"
else
  # Create the lockfile and start the loop
  touch "$LOCKFILE"

  while [ -f "$LOCKFILE" ]; do
    # 0x33 is the hexadecimal code for a f click
    ydotool key 33:1 33:0
    sleep 0.05
  done
fi
