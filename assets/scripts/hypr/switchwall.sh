#!/usr/bin/env bash

cd "$HOME"/Pictures/wallpapers || exit
imgpath=$(yad --width 1000 --height 600 --file --add-preview --large-preview --title='Choose wallpaper')

if [ "$imgpath" == '' ]; then
    echo 'Aborted'
    exit 0
fi

rm "$XDG_CACHE_HOME"/background
ln -s "$imgpath" "$XDG_CACHE_HOME"/background

# Change swww wallpaper
swww img "$imgpath" --transition-step 230 --transition-fps 60 \
    --transition-type grow --transition-angle 30 --transition-duration 1 &
