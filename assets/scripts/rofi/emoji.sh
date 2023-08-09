#!/usr/bin/env bash

menu() {
	cat $HOME/.config/rofi/assets/emoji-list
}

choice=$(menu | rofi -p 'Emoji  ' -dmenu | awk '{print $1}')
echo $choice | wl-copy -n
