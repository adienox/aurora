#!/usr/bin/env bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
udiskie -s &
waybar &
ianny &

"$XDG_CONFIG_HOME"/assets/scripts/hypr/clipboard.sh &
"$XDG_CONFIG_HOME"/assets/scripts/hypr/fullscreen-fade.sh &

# other
sleep 3 && rm "$HOME/test.log" &
