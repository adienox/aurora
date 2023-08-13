#!/usr/bin/env bash

notiSound() {
    if [ "$(dunstctl is-paused)" == 'false' ]; then
        # TODO fix the path
        mpv --no-resume-playback --quiet --keep-open=no $HOME/.config/assets/sounds/notification.mp3
    fi
}

while true; do
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    adapter=$(acpi -a | awk '{print $3}')

    if [[ ($battery_level -ge 100) && ($adapter == 'on-line') ]]; then
        notify-send "Battery Full" "Level: ${battery_level}%"
        notiSound
    elif [[ ($battery_level -le 20) && ($adapter == 'off-line') ]]; then
        notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
        notiSound
    fi
    sleep 120
done
