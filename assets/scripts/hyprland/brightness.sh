#!/usr/bin/env bash

ICON=~/.config/dunst/icons/brightness.svg

notiBrightness () {
    CURRENTBRIGHTNESS=$(brightnessctl | awk 'NR==2 {print $4}' | sed 's/[()]//g; s/%//g')
    notify-send -a custom-notifier 'Brightness' "Current Brightness: $CURRENTBRIGHTNESS%" -h int:value:"$CURRENTBRIGHTNESS" -i $ICON
}

if [ "$1" == 'up' ]
then
    brightnessctl s +5%
elif [ "$1" == 'down' ]
then
    brightnessctl s 5%-
elif [ "$1" == 'up1' ]
then
    brightnessctl s +1%
elif [ "$1" == 'down1' ]
then
    brightnessctl s 1%-
fi

if [ "$(dunstctl is-paused)" == 'false' ]; then
    notiBrightness
fi
