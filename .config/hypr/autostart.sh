#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
blueman-applet &
kdeconnect-indicator &
waybar &
# swww init &
# dunst &
keepassxc -platform xcb &
udiskie -s &

~/.config/hypr/scripts/battery-status.sh &
~/.config/hypr/scripts/bluetooth-auto-off.sh &
~/.config/hypr/scripts/clipboard.sh &

morgen &
obsidian &
todoist &

# other
notify-send -a aurora "Hello $(whoami)! 👋" &
sleep 3 && rm "$HOME/test.log" &