{ config, pkgs, ... }: {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    height = 38;
    spacing = 4;
    modules-left = [
      "wlr/workspaces"
      "custom/weather"
      "hyprland/submap"
    ];
    modules-center = [
      "custom/playerlabel"
    ];
    modules-right = [
      "battery"
      "bluetooth"
      "backlight"
      "pulseaudio"
      "custom/dunst"
      "clock"
      "tray"
    ];

    "wlr/workspaces" = {
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
      exec = "~/.config/scripts/waybar/weather.sh Kathmandu+Nepal";
      return-type = "json";
      format = "{}";
      tooltip = true;
      interval = 600;
    };

    "hyprland/submap" = {
      format = " {}";
      max-length = 8;
      tooltip = false;
    };

    "custom/playerlabel" = {
      format = "<span>{}</span>";
      return-type = "json";
      max-length = 48;
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\"; \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click= "playerctl play-pause";
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
      format-connected-battery = " {device_alias} {device_battery_percentage}%";
    };

    backlight = {
      format = "{icon} {percent}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
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
        default = [
          ""
          ""
          ""
        ];
      };
      on-click-right = "pavucontrol";
    };

    "custom/dunst" = {
      exec = "~/.config/scripts/waybar/dunst.sh";
      on-click = "dunstctl set-paused toggle";
      restart-interval = 1;
    };

    clock = {
      format = "<span font='12' rise='-500'> </span> {:%H:%M}";
      format-alt = "<span font='12' rise='-500'> </span> {:%B %d; % Y}";
      tooltip-format = "<tt>{calendar}</tt>";
    };

    tray = {
      "spacing" = 11;
    };
  };
}

