#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
blueman-applet &
kdeconnect-indicator &
waybar &
keepassxc -platform xcb &
udiskie -s &
xwaylandvideobridge &

~/.config/assets/scripts/hyprland/battery-status.sh &
~/.config/assets/scripts/hyprland/bluetooth-auto-off.sh &
~/.config/assets/scripts/hyprland/clipboard.sh &

morgen &
obsidian &
todoist &

# other
notify-send -a aurora "Hello $(whoami)! 👋" &
sleep 3 && rm "$HOME/test.log" &