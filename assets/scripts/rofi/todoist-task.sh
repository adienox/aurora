#!/usr/bin/env bash

message="<span color='#a6e3a1'><i>The way to get started is to quit talking and begin doing. -Walt Disney</i></span>"

# Get task from user using todoist
content=$(rofi -dmenu -p "Todo" -mesg "$message" -filter "tod #Life " -theme-str "listview {enabled: false;}")

# Check if user typed in task
if [[ -n "$content" ]]; then
	# add task using todoist cli
	todoist quick "$content"
fi