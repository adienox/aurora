#! /bin/sh

read -p 'Enter minutes: ' mins
read -p 'Enter seconds: ' secs

if [ -z $mins ]; then
    mins=10
fi

if [ -z $secs ]; then
    secs=0
fi

tty-countdown -m $mins -s $secs && notify-send "Timer up" && mpv --no-terminal --no-resume-playback /usr/share/sounds/freedesktop/stereo/complete.oga
