#!/usr/bin/bash

hyprctl setcursor 'Bibata-Modern-Ice' 24 &
nm-applet &
blueman-applet &
/usr/lib/kdeconnectd &
kdeconnect-indicator &
waybar &
swww init &
dunst &
keepassxc -platform xcb &
udiskie -s &

~/.config/hypr/scripts/battery-status.sh &
~/.config/hypr/scripts/desktop-portal.sh &
~/.config/hypr/scripts/clipboard.sh &

lock="$HOME/.config/hypr/scripts/lock.sh"
swayidle timeout 300 "$lock" timeout 600 'hyptctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep "$lock" &
morgen &
obsidian &
todoist &

# other
/usr/lib/polkit-kde-authentication-agent-1 &
notify-send -a aurora "hello $(whoami)" &
sleep 3 && rm "$HOME/test.log" &
