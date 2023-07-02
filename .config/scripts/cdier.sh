#!/bin/bash

selected=`find ~/Documents ~/Downloads ~/.config -type d | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

cd $selected

