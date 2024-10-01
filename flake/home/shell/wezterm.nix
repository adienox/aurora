{
  pkgs,
  inputs,
  ...
}: {
  programs.wezterm = {
    enable = false;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    extraConfig = ''
      local wezterm = require("wezterm")

      config = wezterm.config_builder()

      config = {
      	automatically_reload_config = true,
      	enable_tab_bar = false,
      	warn_about_missing_glyphs = false,
      	enable_scroll_bar = false,
      	window_background_opacity = 0.7,
      	scrollback_lines = 10000,
      	enable_wayland = true,
      	check_for_updates = false,
      	default_cursor_style = "BlinkingBar",
      	window_close_confirmation = "NeverPrompt",
      	color_scheme = "Catppuccin Mocha (Gogh)",
      	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" }),
      	font_size = 12.5,
      	colors = {
      		background = "#000000",
      	},
      }

      return config
    '';
  };
}
