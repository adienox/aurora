{ pkgs, default, ... }: {
  # notification daemon
  home.packages = [ pkgs.libnotify ];

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        origin = "top-right";
        alignment = "left";
        width = 300;
        height = 200;
        corner_radius = 8;
        ellipsize = "end";
        follow = "none";
        font = "Readex Pro 12";
        format = "<b>%s</b>\\n%b";
        frame_width = 2;
        frame_color = "#181825e6";
        gap_size = 5;
        highlight = "#cba6f7";
        line_height = 0;
        offset = "20x20";
        horizontal_padding = 8;
        icon_position = "left";
        indicate_hidden = "yes";
        markup = "full";
        min_icon_size = 32;
        max_icon_size = 64;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        notification_limit = 3;
        padding = 8;
        plain_text = "no";
        progress_bar_height = 8;
        progress_bar_corner_radius = 4;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        separator_color = "frame";
        separator_height = 2;
        show_indicators = false;
        show_age_threshold = 60;
        shrink = "no";
        sort = "yes";
        stack_duplicates = true;
        text_icon_padding = 8;
        word_wrap = "yes";
      };

      fullscreen_delay_everything = {
        fullscreen = "delay";
      };

      fullscreen_show_critical = {
        msg_urgency = "critical";
        fullscreen = "show";
      };

      urgency_critical = {
        background = "#000000e6";
        foreground = "#f38ba8";
        frame_color = "#313244e6";
        timeout = 3;
      };
      urgency_low = {
        background = "#000000e6";
        foreground = "#cdd6f4";
        frame_color = "#313244e6";
        timeout = 2;
      };
      urgency_normal = {
        background = "#000000e6";
        foreground = "#cdd6f4";
        frame_color = "#313244e6";
        timeout = 3;
      };
      stack-notifier = {
        appname = "custom-notifier";
        set_stack_tag = "volume";
        history_ignore = "yes";
        urgency = "low";
      };
    };
  };
}
