#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
blueman-applet &
kdeconnect-indicator &
waybar &
swww init &
dunst &
keepassxc -platform xcb &
udiskie -s &

~/.config/hypr/scripts/battery-status.sh &
~/.config/hypr/scripts/bluetooth-auto-off.sh &
~/.config/hypr/scripts/clipboard.sh &

swayidle timeout 300 'gtklock -d' timeout 600 'hyptctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'gtklock -d' &
morgen &
obsidian &
todoist &

# other
notify-send -a aurora "Hello $(whoami)! 👋" &
sleep 3 && rm "$HOME/test.log" &