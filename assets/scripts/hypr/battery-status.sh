#!/usr/bin/env bash

notiSound() {
	play -q "$XDG_CONFIG_HOME"/assets/sounds/notification.mp3
}

while true; do
	battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	adapter=$(acpi -a | awk '{print $3}')

	if [[ ($battery_level -le 20) && ($adapter == 'off-line') ]]; then
		notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
		notiSound
		sleep 120
	else
		sleep 300
	fi
done
