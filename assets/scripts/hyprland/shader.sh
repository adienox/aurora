#!/usr/bin/env bash

sed -i "0,/screen_shader = ~\/.config\/hypr\/shaders\/[^.]*\.frag/s//screen_shader = ~\/.config\/hypr\/shaders\/$1\.frag/" ~/.config/hypr/hyprland.conf
