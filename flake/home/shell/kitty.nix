{default, ...}: {
  programs.kitty = {
    enable = true;
    # shellIntegration.enableZshIntegration = true;
    font = {
      name = "${default.terminal.font}";
      size = 13;
    };
    theme = "Catppuccin-Mocha";
    settings = {
      # Mouse
      cursor_shape = "beam";
      mouse_hide_wait = "3.0";

      # Scrollback
      scrollback_lines = 20000;
      wheel_scroll_multiplier = "3.0";
      touch_scroll_multiplier = "3.0";

      open_url_with = "default";

      # Copying and Selecting
      copy_on_select = false;
      paste_actions = "quote-urls-at-prompt";
      strip_trailing_spaces = "smart";

      # Performance
      sync_to_monitor = true;

      # Terminal Bell
      enable_audio_bell = false;

      # Remote control
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";

      # Window Settings
      window_padding_width = 4;
      confirm_os_window_close = 0;
      hide_window_decorations = true;
      tab_bar_style = "powerline";
      background_opacity = "0.7";
      term = "xterm-kitty";

      background = "#000000";
    };
    keybindings = {"f1" = "debug_config";};
  };
}
