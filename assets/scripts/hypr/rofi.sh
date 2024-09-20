#!/usr/bin/env bash

SCRIPTS="$XDG_CONFIG_HOME/assets/scripts/rofi"

if [ "$1" == "window" ]; then
  rofi -show window
elif [ "$1" == "drun" ]; then
  rofi -show drun
elif [ "$1" == "emoji" ]; then
  rofi -show emoji -modi emoji -theme-str 'element-icon {size: 0px;}' -emoji-mode copy -emoji-file ~/.config/assets/utils/all_emojis.txt
elif [ "$1" == "calc" ]; then
  rofi -show calc -modi calc -theme-str 'mainbox { children: [inputbar, message]; }' -hint-welcome "Pure mathematics is, in its way, the poetry of logical ideas."
elif [ "$1" == "bluetooth" ]; then
  "$SCRIPTS"/bluetooth.sh
elif [ "$1" == "clipboard" ]; then
  "$SCRIPTS"/clipboard.sh
elif [ "$1" == "obsidian-log" ]; then
  "$SCRIPTS"/obsidian-log.py
elif [ "$1" == "obsidian-log-with-screenshot" ]; then
  "$SCRIPTS"/obsidian-log-with-screenshot.sh
elif [ "$1" == "rofi-beats" ]; then
  "$SCRIPTS"/rofi-beats.sh
elif [ "$1" == "task" ]; then
  "$SCRIPTS"/task.sh
elif [ "$1" == "media-log" ]; then
  "$SCRIPTS"/obsidian-media-log.py
fi
