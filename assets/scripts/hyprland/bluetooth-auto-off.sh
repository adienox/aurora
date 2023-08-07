#!/usr/bin/env bash

bluetooth_power=$(bluetoothctl show | awk '{if($1=="Powered:") print $2}')

while true; do
    if [[ $bluetooth_power == "yes" ]]; then
        connected_device=$(bluetoothctl devices Connected | awk '{print $2}')
        if [ -z $connected_device ]; then
            bluetoothctl power off > /dev/null
        fi
    fi
    sleep 300
done
