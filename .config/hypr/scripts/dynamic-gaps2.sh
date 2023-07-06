#!/usr/bin/env bash

config="$HOME/.config/hypr/hyprland.conf"

# Getting default values from hyprland.conf
outer_gaps=$(grep 'gaps_out' < "$config" | awk '{print $3}')
rounding=$(grep 'rounding' < "$config" | awk '{print $3}')

remove_gaps(){
    hyprctl keyword general:gaps_out 0 > /dev/null
    hyprctl setprop address:"$currentwindow" rounding 0 > /dev/null
    hyprctl setprop address:"$currentwindow" forcenoborder 1 > /dev/null
    hyprctl setprop address:"$currentwindow" activebordercolor 0xe61e1e2e > /dev/null
    hyprctl setprop address:"$currentwindow" inactivebordercolor 0xe61e1e2e > /dev/null
}

add_gaps(){
    hyprctl keyword general:gaps_out "$outer_gaps" > /dev/null
    hyprctl setprop address:"$currentwindow" rounding "$rounding" > /dev/null
    hyprctl setprop address:"$currentwindow" forcenoborder 0 > /dev/null
    hyprctl setprop address:"$currentwindow" activebordercolor 0xfff38ba8 0xffb4befe 10deg > /dev/null
    hyprctl setprop address:"$currentwindow" inactivebordercolor 0xff45475a > /dev/null
}

function handle {
    if [[ ${1:0:12} == "activewindow" ]]; then

        # the number of windows in active workspace
        number_of_windows=$(hyprctl activeworkspace | awk '{if($1=="windows:") print $2}')
        # floating state of active window - 0/1
        active_window_float=$(hyprctl activewindow | awk '{if($1=="floating:") print $2}')

        if [ "$number_of_windows" == "1" ]; then
            # getting the id of currently active window
            currentwindow=$(hyprctl activewindow | awk '{if($1 =="Window") print "0x"$2}')
        fi

        if [ "$active_window_float" != "1" ] && [ "$number_of_windows" != "1" ]; then
            add_gaps
        else
            remove_gaps
        fi
    fi
}

# line yanked from docs
socat - "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
