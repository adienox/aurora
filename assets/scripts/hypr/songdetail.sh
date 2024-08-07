#!/usr/bin/env bash

song_info=$(playerctl metadata --format '{{title}}      {{artist}}')

if [[ $(playerctl metadata --format "{{status}}") == "Playing" ]]; then
	echo "$song_info"
fi
