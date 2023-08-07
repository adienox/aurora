#!/bin/bash
# Basic while loop
paplay /usr/share/sounds/freedesktop/stereo/service-login.oga &
touch $HOME/.cache/start-check &
counter=10
while [ $counter -le 255 ]
do
sleep 0.0001
brightnessctl s $counter
((counter++))
done
echo All done
