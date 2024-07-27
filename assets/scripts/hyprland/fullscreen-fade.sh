#!/usr/bin/env bash

function fade {
	brightness=$(cat /sys/class/backlight/*/brightness)

	for ((i = brightness; i >= 0; i--)); do
		brightnessctl s $i >/dev/null
		i=$((i - 5))
	done
	hyprctl dispatch dpms off >/dev/null
	sleep 0.1
	hyprctl dispatch dpms on >/dev/null
	sleep 0.1

	for ((i = 0; i <= brightness; i++)); do
		brightnessctl s $i >/dev/null
		i=$((i + 5))
	done
}

function handle {
	if [[ ${1:0:10} == "fullscreen" ]]; then
		fade
	fi
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
