#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
udiskie -s &
waybar &

~/.config/assets/scripts/hyprland/battery-status.sh &
~/.config/assets/scripts/hyprland/bluetooth-auto-off.sh &
~/.config/assets/scripts/hyprland/clipboard.sh &

# other
sleep 3 && rm "$HOME/test.log" &
