#!/bin/bash

config="$HOME/.config/hypr/hyprland.conf"

# Getting default values from hyprland.conf
outer_gaps=$(grep 'gaps_out' < "$config" | awk '{print $3}')
border=$(grep 'border_size' < "$config" | awk '{print $3}')
rounding=$(grep 'rounding' < "$config" | awk '{print $3}')

remove_gaps(){
    hyprctl keyword general:gaps_out 0 > /dev/null
    hyprctl keyword decoration:rounding 0 > /dev/null
    hyprctl keyword general:border_size 0 > /dev/null
}

add_gaps(){
    hyprctl keyword general:gaps_out "$outer_gaps" > /dev/null
    hyprctl keyword decoration:rounding "$rounding" > /dev/null
    hyprctl keyword general:border_size "$border" > /dev/null
}

remove_gaps_keep_border(){
    hyprctl keyword general:gaps_out 0
    hyprctl keyword decoration:rounding "$rounding" > /dev/null
    hyprctl keyword general:border_size "$border" > /dev/null
    hyprctl setprop address:"$firstwindow" rounding 0 > /dev/null
    hyprctl setprop address:"$firstwindow" activebordercolor 0xe61e1e2e > /dev/null
    hyprctl setprop address:"$firstwindow" inactivebordercolor 0xe61e1e2e > /dev/null
}

default(){
    hyprctl keyword general:gaps_out "$outer_gaps" > /dev/null
    hyprctl keyword decoration:rounding "$rounding" > /dev/null
    hyprctl keyword general:border_size "$border" > /dev/null
    hyprctl setprop address:"$firstwindow" rounding "$rounding" > /dev/null
    hyprctl setprop address:"$firstwindow" activebordercolor -1 > /dev/null
    hyprctl setprop address:"$firstwindow" inactivebordercolor -1 > /dev/null
}

function handle {
    if [[ ${1:0:12} == "activewindow" ]]; then
        # the number of windows in active workspace
        number_of_windows=$(hyprctl activeworkspace | awk '{if($1=="windows:") print $2}')
        # floating state of active window - 0/1
        active_window_float=$(hyprctl activewindow | awk '{if($1=="floating:") print $2}')

        # getting the id of the first active window if its not floating
        if [ "$number_of_windows" == "1" ] && [ "$active_window_float" != '1' ]; then
            firstwindow=$(hyprctl activewindow | awk '{if($1 =="Window") print "0x"$2}')
        fi

        # getting the id of floating window
        if [ "$active_window_float" == '1' ]; then
            floatingwindow=$(hyprctl activewindow | awk '{if($1 =="Window") print $2}')
        fi

        # Unset the floating window variable if the window disappears
        if ! hyprctl clients | grep -q "$floatingwindow"; then
            unset floatingwindow
        fi

        if [ "$active_window_float" != '1' ]; then
            nonfloatingwindow=$(hyprctl activewindow | awk '{if($1 =="Window") print "0x"$2}')
        fi

        # Checking if number of windows in active workspace is 1
        if [[ "$number_of_windows" == "1" ]]; then
            # If it is one, and the active window is not floating, remove gaps, rounding and border
            if [[ "$active_window_float" != "1" ]]; then
                remove_gaps
                # if its floating, adds gaps, rounding and border
            else
                add_gaps
            fi
            # if number of windows is >= two, and there is a floating window
        elif [[ $number_of_windows -ge 2 ]] && [[ -n "$floatingwindow" ]]; then
            # if there is any other non floating window other than the first, revert back to original
            if [[ "$nonfloatingwindow" != "$firstwindow" ]]; then
                default
            else
                # else remove the gaps and remove rounding, border only from first window
                remove_gaps_keep_border
            fi
        else
            default
        fi
    fi
}

# line yanked from docs
socat - "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
