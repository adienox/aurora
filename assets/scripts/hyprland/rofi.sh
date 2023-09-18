#!/usr/bin/env bash

if [ "$1" == "window" ]; then
    rofi -show window
elif [ "$1" == "drun" ]; then
    rofi -show drun
elif [ "$1" == "emoji" ]; then
    rofi -show emoji -modi emoji -theme-str 'element-icon {size: 0px;}' -emoji-mode copy -emoji-file ~/.config/assets/utils/all_emojis.txt
elif [ "$1" == "calc" ]; then
    rofi -show calc -modi calc -theme-str 'mainbox { children: [inputbar, message]; }' -hint-welcome "Pure mathematics is, in its way, the poetry of logical ideas.                 —Albert Einstein"
elif [ "$1" == "bluetooth" ]; then
    $XDG_CONFIG_HOME/assets/scripts/rofi/bluetooth.sh
elif [ "$1" == "clipboard" ]; then
    $XDG_CONFIG_HOME/assets/scripts/rofi/clipboard.sh
fi
