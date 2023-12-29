#!/usr/bin/env bash

ln -s $(pwd)/assets ~/.config
ln -s $(pwd)/assets/backgrounds ~/Pictures/backgrounds

ln -s $(pwd)/.config/doom ~/.config

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
ln -s $(pwd)/.config/nvchad ~/.config/nvim/lua/custom
