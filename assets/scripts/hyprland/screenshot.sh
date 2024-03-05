#!/usr/bin/env bash

DATE=$(date +%Y-%m-%dT%H:%M:%S)
FULLPATH="$HOME/Pictures/Screenshots/$DATE.png"

if [ "$1" == 'full' ]; then
	grim "$FULLPATH"
	wl-copy <"$FULLPATH"
elif [ "$1" == 'partial' ]; then
	grim -g "$(slurp -w 0 -b "#$2""33")" "$FULLPATH"
	wl-copy <"$FULLPATH"
elif [ "$1" == 'ocr' ]; then
	grim -g "$(slurp -w 0 -b "#$2""33")" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png"
fi
