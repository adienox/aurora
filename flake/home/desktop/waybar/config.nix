{ default, ... }: {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    spacing = 4;

    modules-left =
      [ "hyprland/workspaces" "hyprland/submap" "hyprland/window" ];

    modules-center = [ "custom/playerlabel" ];

    modules-right = [
      "custom/recorder"
      "battery"
      "bluetooth"
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
        playerctl -a metadata --format '{"text": "{{markup_escape(title)}}", "tooltip": "{{playerName}} : {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F
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
      format-full = "";
      format-alt = "{icon} {time}";
      format-icons = [ "" "" "" "" "" ];
    };

    bluetooth = {
      format = "";
      on-click = "blueman-manager";
      format-connected = " {device_alias}";
      format-connected-battery =
        " {device_alias} {device_battery_percentage}%";
    };

    backlight = {
      format = "{icon} {percent}%";
      format-icons = [ "" "" "" "" "" "" "" "" "" ];
    };

    pulseaudio = {
      format = "{icon}";
      format-bluetooth = "{icon}  {volume}%";
      format-bluetooth-muted = "{icon}  ";
      format-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "" "" "" ];
      };
      reverse-mouse-scrolling = true;
      reverse-scrolling = true;
      on-click = "swayosd-client --output-volume=mute-toggle";
      on-scroll-up = "swayosd-client --output-volume=raise --max-volume=150";
      on-scroll-down = "swayosd-client --output-volume=lower --max-volume=150";
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
          months = "<span color='${default.xcolors.base07}'><b>{}</b></span>";
          days = "<span color='${default.xcolors.base05}'><b>{}</b></span>";
          weeks = "<span color='${default.xcolors.base0C}'><b>W{}</b></span>";
          weekdays = "<span color='${default.xcolors.base0A}'><b>{}</b></span>";
          today = "<span color='${default.xcolors.base08}'><b>{}</b></span>";
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
      @define-color base00 ${default.xcolors.base00};
      @define-color base01 ${default.xcolors.base01};
      @define-color base02 ${default.xcolors.base02};
      @define-color base03 ${default.xcolors.base03};
      @define-color base04 ${default.xcolors.base04};
      @define-color base05 ${default.xcolors.base05};
      @define-color base06 ${default.xcolors.base06};
      @define-color base07 ${default.xcolors.base07};
      @define-color base08 ${default.xcolors.base08};
      @define-color base09 ${default.xcolors.base09};
      @define-color base0A ${default.xcolors.base0A};
      @define-color base0B ${default.xcolors.base0B};
      @define-color base0C ${default.xcolors.base0C};
      @define-color base0D ${default.xcolors.base0D};
      @define-color base0E ${default.xcolors.base0E};
      @define-color base0F ${default.xcolors.base0F};
      @define-color accent ${default.xcolors.accent};
      @define-color background-floating ${default.rgba.base00 0.4};
      @define-color background-regular  ${
        default.rgba.base00 default.settings.floating_opacity
      };
      @define-color background-semi-trans  ${
        default.rgba.base00 default.settings.opacity
      };
    '';
  };
}
