#! /bin/bash

DEFAULT_SOURCE_INDEX=$(pacmd list-sources | grep "\* index:" | cut -d' ' -f5)

while :
do
  pactl set-source-volume $DEFAULT_SOURCE_INDEX 20%
done

