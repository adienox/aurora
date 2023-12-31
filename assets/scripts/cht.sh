#!/usr/bin/env bash

languages=$(echo "python lua rust c typescript nodejs" | tr ' ' '\n')
core_utils=$(echo "xargs find mv sed awk" | tr ' ' '\n')

selected=$(printf "$languages\n$core_utils" | fzf)
if [[ -z $selected ]]; then
	exit 0
fi

read -p -r "Enter Query: " query

if printf "$languages" | grep -qs "$selected"; then
	query=$(echo "$query" | tr ' ' '+')
	tmux neww bash -c "curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
	tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
