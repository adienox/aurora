{
  default,
  config,
  ...
}:
{
  imports = [
    ./rules.nix
    ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];
      monitor = [
        "eDP-1,1920x1080@120,auto,1"
        "HDMI-A-1,2560x1440@144,auto,1"
      ];
      exec-once = [
        "[workspace 2 silent] ${config.xdg.configHome}/assets/scripts/hypr/emacs.sh"
        "[workspace 4 silent] telegram-desktop"
        "${config.xdg.configHome}/assets/scripts/hypr/autostart.sh"
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

        "col.active_border" = "0xff${default.colors.base0E} 0xff${default.colors.base0C} 45deg";
        "col.inactive_border" = "0xff${default.colors.base02}";

        # sensitivity = 1.0; # for mouse cursor

        layout = "dwindle";
      };
      cursor = {
        no_warps = true;
        hide_on_key_press = true;
        no_hardware_cursors = true;
      };

      decoration = {
        rounding = 5;

        shadow = {
          range = 5;
          render_power = 4;
          color = "0x33000000";
          color_inactive = "0x22000000";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 5;
          contrast = 1.2;
          ignore_opacity = true;
          new_optimizations = true;
        };
      };

      animations = {
        enabled = true;
        first_launch_animation = false;
        bezier = "overshot,0.13,0.99,0.29,1.1";
        animation = [
          "windows,1,4,default,slide"
          "border,1,10,default"
          "fade,1,10,default"
          "layers,1,3,default,fade"
          "workspaces,1,6,default,slide"
        ];
      };

      dwindle = {
        pseudotile = true; # enable pseudotiling on dwindle
        force_split = 0;
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
        vfr = true;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        new_window_takes_over_fullscreen = true;
        initial_workspace_tracking = 0;
      };
    };
    # extraConfig = ''
    #   device {
    #     name = ite-tech.-inc.-ite-device(8910)-keyboard
    #     enabled = false
    #   }
    #
    #   device {
    #     name = ite-tech.-inc.-ite-device(8910)-wireless-radio-control
    #     enabled = false
    #   }
    # '';
  };
}
