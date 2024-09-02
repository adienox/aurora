#!/usr/bin/env bash
echo "Run nixos-rebuild switch --flake .#anomaly to setup os"
echo "Run nix run home-manager/master -- switch --flake .#nox to setup home config"

if [ ! -d "$XDG_CONFIG_HOME/assets" ]; then
	ln -s "$(pwd)/assets" "$XDG_CONFIG_HOME/assets"
fi

if [ ! -d "$HOME/.local/bin" ]; then
	ln -s "$(pwd)/assets/scripts/utils" "$HOME/.local/bin"
fi

if [ ! -d "$XDG_PICTURES_DIR/wallpapers" ]; then
	ln -s "$(pwd)/assets/wallpapers" "$XDG_PICTURES_DIR/wallpapers"
fi

if [ ! -f "$XDG_CACHE_HOME/background" ]; then
	ln -s "$XDG_PICTURES_DIR"/wallpapers/astronaut.jpg "$XDG_CACHE_HOME"/background
fi

if [ ! -d "$XDG_CONFIG_HOME/doom" ]; then
	ln -s "$(pwd)/.config/doom" "$XDG_CONFIG_HOME/doom"
fi

if [ ! -d "$XDG_CONFIG_HOME/zellij" ]; then
	ln -s "$(pwd)/.config/zellij" "$XDG_CONFIG_HOME/zellij"
fi

if [ ! -d "$XDG_CONFIG_HOME/nvim" ]; then
	git clone https://github.com/NvChad/NvChad "$XDG_CONFIG_HOME"/nvim --depth 1
	ln -s "$(pwd)/.config/nvchad" "$XDG_CONFIG_HOME/nvim/lua/custom"
fi

if [ ! -f "$XDG_CONFIG_HOME/mpv/scripts/note.lua" ]; then
	ln -s "$(pwd)/.config/mpv/note.lua" "$XDG_CONFIG_HOME/mpv/scripts/note.lua"
fi

if [ ! -f "$XDG_CONFIG_HOME/mpv/scripts/rename.lua" ]; then
	ln -s "$(pwd)/.config/mpv/rename.lua" "$XDG_CONFIG_HOME/mpv/scripts/rename.lua"
fi
