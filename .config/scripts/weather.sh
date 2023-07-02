#!/usr/bin/env bash

locations=$(echo "Kathmandu Birtamod" | tr ' ' '\n')

selected=$(echo "$locations" | fzf)
if [[ -z $selected ]]; then
    exit 0
fi

if echo "$locations" | grep -qs "$selected"; then
    tmux neww bash -c "curl wttr.in/$selected & while [ : ]; do sleep 1; done"
fi
