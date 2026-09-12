#!/usr/bin/env bash

LOCKFILE="/tmp/antiafk_active"

KEY_A=30
KEY_D=32

rand_range() {
    awk -v min="$1" -v max="$2" -v seed="$(date +%s%N)" 'BEGIN{srand(seed); print min+rand()*(max-min)}'
}

tap_key() {
    local code=$1
    local duration=$2
    ydotool key "${code}:1"
    sleep "$duration"
    ydotool key "${code}:0"
}

if [ -f "$LOCKFILE" ]; then
    rm "$LOCKFILE"
else
    touch "$LOCKFILE"

    while [ -f "$LOCKFILE" ]; do
        cycle_hold=$(rand_range 0.04 0.12)

        tap_key $KEY_A "$cycle_hold"
        sleep "$(rand_range 1 4)"

        tap_key $KEY_D "$cycle_hold"
        sleep "$(rand_range 1 4)"
    done
fi
