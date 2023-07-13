#!/usr/bin/env bash

DATE=$(date +%Y%m%d_%H%M%S)
FULLPATH="$HOME/Pictures/Screenshots/$DATE.png"

if [ "$1" == 'full' ]; then
    grim "$FULLPATH"
    wl-copy < "$FULLPATH"
elif [ "$1" == 'partial' ]; then
    grim -g "$(slurp)" "$FULLPATH"
    wl-copy < "$FULLPATH"
elif [ "$1" == 'ocr' ]; then
    grim -g "$(slurp)" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png"
fi
