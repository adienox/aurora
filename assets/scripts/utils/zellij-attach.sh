#!/usr/bin/env bash

ZELLIJ_SESSIONS=$(zellij ls 2>/dev/null)

if [[ -z "$ZELLIJ_SESSIONS" ]]; then
	zellij a -c "main"
fi

output=$(printf "$ZELLIJ_SESSIONS\nclear-all" | fzf --ansi --prompt="Session: " --print-query)

read -r -d " " search_query match_item <<<"$output"

if [[ -n "$match_item" ]]; then
	session=$(echo "$match_item" | cut -d " " -f 1)
else
	session="$search_query"
fi

if [[ "$session" == "clear-all" ]]; then
	zellij da -y
	zellij a -c "main"
else
	zellij a -c "$session"
fi
