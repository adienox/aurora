#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
blueman-applet &
kdeconnect-indicator &
waybar &
keepassxc -platform xcb &
udiskie -s &

~/.config/scripts/hyprland/battery-status.sh &
~/.config/scripts/hyprland/bluetooth-auto-off.sh &
~/.config/scripts/hyprland/clipboard.sh &
~/Documents/xwaylandvideobridge/result/bin/xwaylandvideobridge &

morgen &
obsidian &
todoist &

# other
notify-send -a aurora "Hello $(whoami)! 👋" &
sleep 3 && rm "$HOME/test.log" &