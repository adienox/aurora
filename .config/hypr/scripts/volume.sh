#!/bin/bash

VOLUME=$(pamixer --get-volume)
MUTESTATE=$(pamixer --get-mute)
MUTEICON=~/.config/dunst/icons/volume-muted.svg

notiVolume () {
    if [ "$(dunstctl is-paused)" == 'false' ]; then
        CURRENTVOLUME=$(pamixer --get-volume)
        notify-send -a custom-notifier 'Volume' "Current Volume: $CURRENTVOLUME%" -h int:value:$CURRENTVOLUME -i $ICON
    fi
}

notiMute () {
    if [ "$(dunstctl is-paused)" == 'false' ]; then
        notify-send -a custom-notifier 'Volume' -i $MUTEICON
    fi
}

if [ "$VOLUME" -ge 66 ]; then
    ICON=~/.config/dunst/icons/volume-high.svg
elif [ "$VOLUME" -ge 33 ]; then
    ICON=~/.config/dunst/icons/volume-medium.svg
else
    ICON=~/.config/dunst/icons/volume-low.svg
fi

if [ "$1" == 'up' ] && [ "$MUTESTATE" == 'false' ]; then
    pamixer -i 5
    notiVolume
elif [ "$1" == 'down' ] && [ "$MUTESTATE" == 'false' ]; then
    pamixer -d 5
    notiVolume
elif [ "$1" == 'toggleMute' ]; then
    pamixer -t
    MUTESTATE=$(pamixer --get-mute)

    if [ "$MUTESTATE" == 'true' ]; then
        notiMute
    else
        notiVolume
    fi
else
    notiMute
fi
