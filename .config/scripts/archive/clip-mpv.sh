#! /bin/bash

url=$(xclip -o -sel c)
notify-send "Fetching" "$url"
title=$(yt-dlp --get-title $url)
notify-send "mpv" "$title"
mpv $url
