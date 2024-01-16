#!/usr/bin/env bash

# Check if a title is provided as a command-line argument
if [ $# -gt 0 ]; then
	title=$1
else
	title="Sudo password prompt"
fi

zenity --password --title="$title" 2>/dev/null
