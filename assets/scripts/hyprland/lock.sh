#!/usr/bin/env bash

swaylock \
	-e \
	--screenshots \
	--indicator \
	--clock \
	--datestr '%b %d, %Y' \
	--inside-wrong-color f38ba8 \
	--ring-wrong-color 11111b \
	--inside-clear-color a6e3a1 \
	--ring-clear-color 11111b \
	--inside-ver-color 89b4fa \
	--ring-ver-color 11111b \
	--text-color cdd6f4 \
	--indicator-radius 80 \
	--indicator-thickness 5 \
	--effect-blur 10x7 \
	--effect-vignette 0.2:0.2 \
	--ring-color 11111b \
	--key-hl-color f5c2e7 \
	--line-color 313244 \
	--inside-color 0011111b \
	--separator-color 00000000 \
	--fade-in 0.1 &
