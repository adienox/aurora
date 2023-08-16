#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
blueman-applet &
kdeconnect-indicator &
keepassxc -platform xcb &
udiskie -s &
xwaylandvideobridge &
waybar &
wlsunset -t 5200 -S 8:00 -s 19:30 &

~/.config/assets/scripts/hyprland/battery-status.sh &
~/.config/assets/scripts/hyprland/bluetooth-auto-off.sh &
~/.config/assets/scripts/hyprland/clipboard.sh &

# other
notify-send -a aurora "Hello $(whoami)! 👋" &
sleep 3 && rm "$HOME/test.log" &
