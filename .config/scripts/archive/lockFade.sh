#!/usr/bin/env bash

fade() {
  # Setting the counter variable to current brightness value
  counter=$(brightnessctl g)
  # Backing up the brightness value for restore
  echo "$counter" >> $HOME/.cache/brightness

  # Setting brightness to 1 decrementally
  while [ $counter -ge 1 ]
  do
    sleep 0.005
    brightnessctl s $counter -q
    ((counter--))
  done
}

restore() {
  # Getting original value of brightness from backup
  brightness=$(cat $HOME/.cache/brightness)
  counter=1

  # Setting brightness to its original value incrementally
  while [ $counter -le $brightness ]
  do
    sleep 0.0001
    brightnessctl s $counter -q
    ((counter++))
  done

  # Removing the backup
  rm $HOME/.cache/brightness
}

case "$1" in
  fade)
    fade
  ;;
  restore)
    restore
  ;;
  *)
     echo "Unknown argument"
  ;;
esac
