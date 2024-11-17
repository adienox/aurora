#!/usr/bin/env bash

target_workspace=$1
# get current active monitor
monitor=$(hyprctl activeworkspace | grep 'monitorID:' | awk '{print $2}')

# check if the script is called from monitor 1
if [ "$monitor" == "1" ]; then
    # switch 1-5 to 6-10
    if [ "$target_workspace" -le 5 ]; then
        target_workspace=$((target_workspace + 5))
    # switch 6-10 to 1-5
    elif [ "$target_workspace" -ge 6 ]; then
        target_workspace=$((target_workspace - 5))
    fi
fi

hyprctl dispatch workspace "$target_workspace"
