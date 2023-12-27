#!/bin/sh

ARGS="--no-resume-playback"

notification(){
	notify-send "Playing now: " "$@" --icon=media-tape
}

menu(){
	printf "1. Chill beats for LEGO building 🧱\n"
	printf "2. 1 A.M Chill Session 🌌\n"
	printf "3. 2 A.M Chill Session 🌌\n"
	printf "4. Earth's History as an Animated Timelapse 🌏\n"
}

main() {
	choice=$(menu | rofi -dmenu -p 'Lofi 󰎈' | cut -d. -f1)

	case $choice in
		1)
			notification "Chill beats for LEGO building 🧱";
      URL=$HOME/Videos/lofi/Chill\ beats\ for\ LEGO\ building\ 🧱.webm
			break
			;;
		2)
			notification "1 A.M Chill Session 🌌";
      URL=$HOME/Videos/lofi/1\ A.M\ Chill\ Session\ 🌌.webm
			break
			;;
		3)
			notification "2 A.M Chill Session 🌌";
      URL=$HOME/Videos/lofi/2\ A.M\ Chill\ Session\ 🌌.webm
			break
			;;
		4)
			notification "Earth's History as an Animated Timelapse ☕️🎶";
      URL=$HOME/Videos/lofi/Earth\'s\ History\ as\ an\ Animated\ Timelapse.webm
			break
			;;
	esac
  
  mpv $ARGS --start=00:40 --title="radio-mpv" "$URL"
}

pkill -f radio-mpv || main
