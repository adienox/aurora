{ config, ... }: let
  colors = config.colorScheme.colors;
in  {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    spacing = 4;

    modules-left = [
      "hyprland/workspaces"
      "custom/weather"
      "hyprland/submap"
      "hyprland/window"
    ];

    modules-center = [ "custom/playerlabel" ];

    modules-right = [
      "custom/recorder"
      "battery"
      "bluetooth"
      "backlight"
      "pulseaudio"
      "custom/notification"
      "clock"
      "tray"
    ];

    "hyprland/workspaces" = {
      active-only = false;
      all-outputs = true;
      disable-scroll = false;
      on-scroll-up = "hyprctl dispatch workspace e-1";
      on-scroll-down = "hyprctl dispatch workspace e+1";
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
      };
    };

    "custom/weather" = {
      exec = "~/.config/assets/scripts/waybar/weather.sh Kathmandu+Nepal";
      return-type = "json";
      format = "{}";
      tooltip = true;
      interval = 600;
      on-click = "pkill -RTMIN+8 waybar";
      signal = 8;
    };

    "hyprland/submap" = {
      format = " {}";
      max-length = 8;
      tooltip = false;
    };

    "hyprland/window" = { format = ""; };

    "custom/playerlabel" = {
      format = "<span>{}</span>";
      return-type = "json";
      max-length = 48;
      exec = ''
        playerctl -a metadata --format '{"text": "{{artist}} - {{markup_escape(title)}}", "tooltip": "{{playerName}} : {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F
      '';
      on-click = "playerctl play-pause";
    };

    "custom/recorder" = {
      exec = "~/.config/assets/scripts/waybar/recorder.sh";
      on-click = "~/.config/assets/scripts/hyprland/screenrecord.sh";
      restart-interval = 1;
    };

    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "<span font='14' rise='-2000'>{icon}</span> {capacity}%";
      format-charging = " {capacity}%";
      format-plugged = " {capacity}%";
      format-alt = "{icon} {time}";
      format-icons = [ "" "" "" "" "" ];
    };

    bluetooth = {
      format = "";
      format-connected = " {device_alias}";
      format-connected-battery =
        " {device_alias} {device_battery_percentage}%";
    };

    backlight = {
      format = "{icon} {percent}%";
      format-icons = [ "" "" "" "" "" "" "" "" "" ];
    };

    pulseaudio = {
      format = "<span font = '12' rise='-1000'>{icon}</span> {volume}%";
      format-alt = "{format_source}";
      format-bluetooth = "{icon}  {volume}%";
      format-bluetooth-muted = "{icon}  ";
      format-muted = "";
      format-source = " {volume}%";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "" "" "" ];
      };
      on-click-right = "pavucontrol";
    };

    "custom/dunst" = {
      exec = "~/.config/assets/scripts/waybar/dunst.sh";
      on-click = "dunstctl set-paused toggle";
      restart-interval = 1;
    };

    "custom/notification" = {
      tooltip = false;
      format = "{icon}";
      format-icons = {
        notification = "";
        none = "";
        dnd-notification = "";
        dnd-none = "";
        inhibited-notification = "";
        inhibited-none = "";
        dnd-inhibited-notification = "";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };

    clock = {
      format = " {:%H:%M}";
      format-alt = " {:%B %d, %Y}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "month"; # month/year
        mode-mon-col = 3; # only relevant if mode is year
        weeks-pos = "right";
        on-scroll = 1;
        on-click-right = "mode";
        format = {
          months = "<span color='#${colors.base07}'><b>{}</b></span>";
          days = "<span color='#${colors.base05}'><b>{}</b></span>";
          weeks = "<span color='#${colors.base0C}'><b>W{}</b></span>";
          weekdays = "<span color='#${colors.base0A}'><b>{}</b></span>";
          today = "<span color='#${colors.base08}'><b>{}</b></span>";
        };
      };
      actions = {
        on-click-right = "mode";
        on-click-forward = "tz_up";
        on-click-backward = "tz_down";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };
    };

    tray = { "spacing" = 12; };
  };

  xdg.configFile = {
    "waybar/colors.css".text = ''
      @define-color base00 #${colors.base00};
      @define-color base01 #${colors.base01};
      @define-color base02 #${colors.base02};
      @define-color base03 #${colors.base03};
      @define-color base04 #${colors.base04};
      @define-color base05 #${colors.base05};
      @define-color base06 #${colors.base06};
      @define-color base07 #${colors.base07};
      @define-color base08 #${colors.base08};
      @define-color base09 #${colors.base09};
      @define-color base0A #${colors.base0A};
      @define-color base0B #${colors.base0B};
      @define-color base0C #${colors.base0C};
      @define-color base0D #${colors.base0D};
      @define-color base0E #${colors.base0E};
      @define-color base0F #${colors.base0F};
    '';
  };
}
