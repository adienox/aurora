#!/usr/bin/env bash

ARGS="--no-resume-playback"
directory="$HOME/Videos/lofi"

notification() {
	notify-send "Playing now: " "$@" --icon=media-tape
}

menu() {
	# beats=$(ls -1 "$HOME/Videos/lofi/")
	beats=("$directory"/*)
	for beat in "${beats[@]}"; do
		filename="$(basename "$beat")"
		echo "${filename%.*}"
	done
}

main() {
	choice=$(menu | rofi -dmenu -p 'Lofi 󰎈')

	if [ -n "$choice" ]; then
		notification "$choice"
		URL=$(ls "$directory/$choice"*)

		mpv $ARGS --title="radio-mpv" "$URL"
	fi
}

pkill -f radio-mpv || main
