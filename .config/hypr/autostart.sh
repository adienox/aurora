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

lock="$HOME/.config/hypr/scripts/lock.sh"
swayidle timeout 300 "$lock" timeout 600 'hyptctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep "$lock" &
morgen &
obsidian &
todoist &

# other
/nix/store/$(ls -la /nix/store | grep polkit-kde-agent | grep '^d' | awk 'NR==1{print $9}')/libexec/polkit-kde-authentication-agent-1 &
notify-send -a aurora "Hello $(whoami)! 👋" &
sleep 3 && rm "$HOME/test.log" &
