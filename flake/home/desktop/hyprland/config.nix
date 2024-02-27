{ default, ... }: {
  imports = [ ./rules.nix ./binds.nix ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = ",preferred,auto,1";
      exec-once = [
        "[workspace 3 silent] obsidian"
        "[workspace 5 silent] telegram-desktop"
        "[workspace 6 silent] ticktick"
        "~/.config/assets/scripts/hyprland/autostart.sh"
      ];
      input = {
        kb_layout = "us";

        follow_mouse = true;
        natural_scroll = true;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;

        border_size = 2;

        "col.active_border" =
          "0xff${default.colors.base0E} 0xff${default.colors.base02} 0xff${default.colors.base02} 0xff${default.colors.base0E} 215deg";
        "col.inactive_border" = "0xff${default.colors.base02}";

        sensitivity = 1.0; # for mouse cursor

        no_cursor_warps = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;

        drop_shadow = true;
        shadow_range = 35;
        shadow_render_power = 3;
        "col.shadow" = "0x33000000";
        "col.shadow_inactive" = "0x22000000";

        blur = {
          enabled = true;
          size = 8; # minimum 1
          passes = 3; # minimum 1, more passes = more resource intensive.
          ignore_opacity = true;
          new_optimizations = true;
          contrast = 1.2;
          xray = false;
          brightness = 1;
        };
      };

      animations = {
        enabled = true;
        bezier = "overshot,0.13,0.99,0.29,1.1";
        animation = [
          "windows,1,4,default,slide"
          "border,1,10,default"
          "fade,1,10,default"
          "workspaces,1,6,default,slide"
        ];
      };

      dwindle = {
        pseudotile = true; # enable pseudotiling on dwindle
        force_split = 0;
        no_gaps_when_only = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_cancel_ratio = 0.6;
        workspace_swipe_min_speed_to_force = 5;
      };

      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        swallow_regex = "^(org.wezfurlong.wezterm|floating)$";
        vfr = true;
        key_press_enables_dpms = true;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      plugin = {
        hycov = {
          overview_gappo = 20; # gaps width from screen edge
          overview_gappi = 14; # gaps width from clients
          enable_hotarea =
            1; # enable mouse cursor hotarea, when cursor enter hotarea, it will toggle overview
          hotarea_monitor =
            "all"; # monitor name which hotarea is in, default is all
          hotarea_pos =
            1; # position of hotarea (1: bottom left, 2: bottom right, 3: top left, 4: top right)
          hotarea_size = 10; # hotarea size, 10x10
          swipe_fingers = 4; # finger number of gesture,move any directory
          move_focus_distance =
            100; # distance for movefocus,only can use 3 finger to move
          enable_gesture = 1; # enable gesture
          auto_exit = 1; # enable auto exit when no client in overview
          auto_fullscreen =
            0; # auto make active window maximize after exit overview
          only_active_workspace = 0; # only overview the active workspace
          only_active_monitor = 0; # only overview the active monitor
          enable_alt_release_exit =
            1; # alt swith mode arg,see readme for detail
          alt_replace_key =
            "Super_L"; # alt swith mode arg,see readme for detail
          alt_toggle_auto_next =
            0; # auto focus next window when toggle overview in alt swith mode
          click_in_cursor =
            1; # when click to jump,the target windwo is find by cursor, not the current foucus window.
          hight_of_titlebar = 0; # height deviation of title bar height
        };
      };
    };
  };
}
