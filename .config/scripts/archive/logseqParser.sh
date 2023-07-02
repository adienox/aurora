#! /bin/bash

url=$(xclip -o -sel c)

$HOME/.config/scripts/youtubeData.py $url | xclip -i -sel c

notify-send "Parser" "Youtube Link Parsed"

