{ config, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    settings = {
      monitor = ",preferred,auto,1";
      source = [
        "~/.config/hypr/env.conf"
      ];
      input = {
        kb_options = "ctrl:nocaps"; # Swap capsLock with ctrl
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

        border_size = 1;

        "col.active_border" = "0xfff38ba8 0xffb4befe 270deg";
        "col.inactive_border" = "0xff45475a";

        "col.group_border" = "0xff89dceb";
        "col.group_border_active" = "0xfff9e2af";

        sensitivity = 1.0; # for mouse cursor

        no_cursor_warps = true;
      };

      decoration = {
        rounding = 10;
        multisample_edges = true;
        #screen_shader = ~/.config/hypr/shaders/bluefilter.frag

        drop_shadow = true;
        shadow_range = 100;
        shadow_render_power = 3;
        shadow_offset = "0 5";
        "col.shadow" = "0x33000000";
        "col.shadow_inactive" = "0x22000000";

        blur = true;
        blur_size = 6; # minimum 1
        blur_passes = 4; # minimum 1, more passes = more resource intensive.
        blur_ignore_opacity = true;
        blur_new_optimizations = true;
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
        workspace_swipe_cancel_ratio = 0.7;
        workspace_swipe_min_speed_to_force = 5;
      };

      misc = {
        focus_on_activate = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        vfr = true;
        key_press_enables_dpms = true;
      };
      exec-once = [
        "dbus-update-activation-environment - -systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "~/.config/hypr/autostart.sh"
      ];
    };
  };
  imports = [
    ./rules.nix
    ./binds.nix
  ];
  wayland.windowManager.hyprland.extraConfig = ''
    env = "QT_QPA_PLATFORM,wayland;xcb";
    env = "QT_QPA_PLATFORMTHEME,qt5ct";
  '';
}
