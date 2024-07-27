#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
udiskie -s &
waybar &
ianny &

"$XDG_CONFIG_HOME"/assets/scripts/hyprland/clipboard.sh &
"$XDG_CONFIG_HOME"/assets/scripts/hyprland/fullscreen-fade.sh &

# other
sleep 3 && rm "$HOME/test.log" &
