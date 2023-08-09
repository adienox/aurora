#!/usr/bin/env bash

cliphist list | rofi -theme-str "#listview{columns: 1;}" -dmenu -p 'Clipboard 󰅌 '| cliphist decode | wl-copy