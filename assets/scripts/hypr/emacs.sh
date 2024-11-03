#!/usr/bin/env bash

# Check the status of the emacs.service for the user
status=$(systemctl --user is-active emacs.service)

# Check if the status is 'active'
if [ "$status" == "active" ]; then
  echo "Emacs service is active. Starting emacsclient..."
  emacsclient -c &
else
  echo "Emacs service is not active. Starting emacs.service..."
  systemctl --user start emacs.service && emacsclient -c &
fi
