#!/bin/bash

ICON=/usr/share/icons/Papirus-Dark/16x16/devices/battery.svg

notiSound () {
    if [ "$(dunstctl is-paused)" == 'false' ]; then
        paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    fi
}

while true; do
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    adapter=$(acpi -a | awk '{print $3}')

    if [[ ($battery_level -ge 100) && ($adapter == 'on-line') ]]; then
        notify-send -i $ICON "Battery Full" "Level: ${battery_level}%"
        notiSound
    elif [[ ($battery_level -le 20) && ($adapter == 'off-line') ]]; then
        notify-send -i $ICON --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
        notiSound
    fi
    sleep 60
done
