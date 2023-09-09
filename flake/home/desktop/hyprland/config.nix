{ ... }: {
  imports = [ ./rules.nix ./binds.nix ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = ",preferred,auto,1";
      exec-once = [
        "[workspace 3 silent] obsidian"
        "[workspace 8 silent] morgen"
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

        "col.active_border" = "0xffcba6f7";
        "col.inactive_border" = "0xff1e1e2e";
        "col.group_border" = "0xff89dceb";
        "col.group_border_active" = "0xfff9e2af";

        sensitivity = 1.0; # for mouse cursor

        no_cursor_warps = true;
      };

      decoration = {
        rounding = 10;
        multisample_edges = true;

        drop_shadow = true;
        shadow_range = 100;
        shadow_render_power = 3;
        shadow_offset = "0 5";
        "col.shadow" = "0x33000000";
        "col.shadow_inactive" = "0x22000000";

        blur = {
          enabled = true;
          size = 6; # minimum 1
          passes = 4; # minimum 1, more passes = more resource intensive.
          ignore_opacity = true;
          new_optimizations = true;
        };
      };

      animations = {
        enabled = true;
        bezier = "overshot,0.13,0.99,0.29,1.1";
        animation = [
          "windows,1,4,overshot,slide"
          "border,1,10,default"
          "fade,1,10,default"
          "workspaces,1,6,overshot,slide"
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
        focus_on_activate = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        swallow_regex = "^(org\.wezfurlong\.wezterm|floating)$";
        vfr = true;
        key_press_enables_dpms = true;
        disable_splash_rendering = true;
      };
    };
  };
}
