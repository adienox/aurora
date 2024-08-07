#!/usr/bin/env bash
# This script requires the class of the window to be passed as the first argument
# This script requires the command to open the window to be passed as the second argument

fullscreen() {
	state=$(hyprctl activewindow | awk '{if($1 == "fullscreen:") print $2}')
	if [ "$state" == 0 ] && [ "$activewindow" == "$1" ]; then
		hyprctl dispatch fullscreen
	fi
}

hyprctl dispatch focuswindow "$1"

activewindow=$(hyprctl activewindow | awk '{if($1 == "class:") print $2}')
if [ "$activewindow" != "$1" ]; then
	$2
else
	sleep 0.1
	fullscreen "$@"
fi
