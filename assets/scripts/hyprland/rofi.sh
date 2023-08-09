#!/usr/bin/env bash

if [ "$1" == "window" ]; then
    rofi -show window
elif [ "$1" == "drun" ]; then
    rofi -show drun -theme-str 'entry {placeholder: "Search..."; placeholder-color: rgba(205, 214, 244, 0.5); cursor: false; }'
elif [ "$1" == "emoji" ]; then
    rofi -show emoji -modi emoji -theme-str 'element-icon {size: 0px;}'
elif [ "$1" == "calc" ]; then
    rofi -show calc -modi calc -theme-str 'mainbox { children: [inputbar, message]; }' -hint-welcome "Pure mathematics is, in its way, the poetry of logical ideas.                 —Albert Einstein"
elif [ "$1" == "bluetooth" ]; then
    ~/.config/scripts/rofi/bluetooth.sh
fi
