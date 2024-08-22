#!/usr/bin/env bash

output=$(pactl list source-outputs | grep application.name)

if [[ -n "$output" ]]; then
	echo ""
else
	echo ""
fi
