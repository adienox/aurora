#!/usr/bin/env bash

file=$(date +'%Y-%m-%d.md')
path="$XDG_DOCUMENTS_DIR/Knowledge Garden/Cards/Temporal/Daily"
template="$XDG_DOCUMENTS_DIR/Knowledge Garden/Extras/Templates/Temporal/Daily.md"
mediaPath="$XDG_DOCUMENTS_DIR/Knowledge Garden/Extras/Media"
mediaName=$(date +'%Y%m%d_%H%M%S.png')

grim -g "$(slurp)" "$mediaPath/$mediaName"

log=$(rofi -dmenu -p "Log  " -mesg "<span color='#a6e3a1'><i>Your future self will be proud of you for doing this today!</i></span>" -markup -theme-str 'listview { enabled: false;}')

# Check if the path exists, and if not, exit
if [ ! -d "$path" ]; then
    echo "Error: Path does not exist: $path"
    exit 1
fi

cd "$path" || exit 1

# Check if the file exists, and if not, create it using the template
if [ ! -f "$file" ]; then
    cp $template $file
fi

if [ -n "$log" ]; then
  echo -e -n "\n- $log [[$mediaName|linked screenshot]]" >> $file
  sed -i -e '/^# Tasks$/!b;:a;$!{N;ba;}' -e 's/\(.*\)\n\(.*\)/\2\n\1/' $file
fi
