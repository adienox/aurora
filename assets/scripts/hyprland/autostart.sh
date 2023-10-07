#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
blueman-applet &
kdeconnect-indicator &
udiskie -s &
waybar &
swaync &
wlsunset -t 5000 -S 8:00 -s 19:30 &

~/.config/assets/scripts/hyprland/battery-status.sh &
~/.config/assets/scripts/hyprland/bluetooth-auto-off.sh &
~/.config/assets/scripts/hyprland/clipboard.sh &

# other
notify-send -a aurora "Hello $(whoami)! 👋" &
sleep 3 && rm "$HOME/test.log" &
