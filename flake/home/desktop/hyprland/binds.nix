{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";
      "$ALT" = "ALT";
      bind = [
        # Kitty
        "$MOD, RETURN, exec, kitty"
        "$MOD SHIFT, RETURN, exec, kitty --start-as=fullscreen -o 'font_size=16' --title all_is_kitty"

        # Alt Kitty
        "$ALT, RETURN, exec, kitty --title fly_is_kitty"
        "$ALT, 1, exec, kitty --title fly_is_kitty cava"
        "$ALT, 2, exec, kitty --title fly_is_kitty pulsemixer"

        # Applications
        "$MOD, W, exec, ~/.config/scripts/hyprland/focus.sh librewolf librewolf"
        "$MOD, O, exec, ~/.config/scripts/hyprland/focus.sh obsidian obsidian"
        "$MOD, C, exec, ~/.config/scripts/hyprland/focus.sh Morgen morgen"
        "$MOD, E, exec, ~/.config/scripts/hyprland/focus.sh Code 'code --enable-features=UseOzonePlatform --ozone-platform=wayland'"
        "$MOD, T, exec, ~/.config/scripts/hyprland/focus.sh Todoist todoist"
        "$MOD, X, exec, wlogout"

        # Rofi
        "$MOD SHIFT, I, exec, ~/.config/scripts/hyprland/rofi.sh emoji"
        "$ALT, Space, exec, ~/.config/scripts/hyprland/rofi.sh calc"
        "$MOD, B, exec, ~/.config/scripts/hyprland/rofi.sh bluetooth"
        "$MOD, Space, exec, ~/.config/scripts/hyprland/rofi.sh drun"
        "$ALT, Tab, exec, ~/.config/scripts/hyprland/rofi.sh window"

        # Clipboard
        "$MOD, V, exec, ~/.config/scripts/rofi/clipboard.sh"
        "$MOD SHIFT, V, exec, cliphist wipe"

        # Hyprland Bindings
        "$MOD SHIFT, Q, killactive, "
        "$MOD, F, togglefloating, "
        "$MOD, P, pseudo,"

        # Screenshot
        ", Print, exec, ~/.config/scripts/hyprland/screenshot.sh full"
        "SHIFT, Print, exec, ~/.config/scripts/hyprland/screenshot.sh partial"
        "$MOD SHIFT, T, exec, ~/.config/scripts/hyprland/screenshot.sh ocr"

        # Move focus with MOD + vim keys
        "$MOD, H, movefocus, l"
        "$MOD, J, movefocus, d"
        "$MOD, K, movefocus, u"
        "$MOD, L, movefocus, r"

        # Move window with MOD + vim keys
        "$MOD SHIFT, H, movewindow, l"
        "$MOD SHIFT, J, movewindow, d"
        "$MOD SHIFT, K, movewindow, u"
        "$MOD SHIFT, L, movewindow, r"

        # Switch workspaces with MOD + [0-9]
        "$MOD, 1, workspace, 1"
        "$MOD, 2, workspace, 2"
        "$MOD, 3, workspace, 3"
        "$MOD, 4, workspace, 4"
        "$MOD, 5, workspace, 5"
        "$MOD, 6, workspace, 6"
        "$MOD, 7, workspace, 7"
        "$MOD, 8, workspace, 8"
        "$MOD, 9, workspace, 9"

        # Move active window to a workspace with MOD + SHIFT + [0-9]
        "$MOD SHIFT, 1, movetoworkspace, 1"
        "$MOD SHIFT, 2, movetoworkspace, 2"
        "$MOD SHIFT, 3, movetoworkspace, 3"
        "$MOD SHIFT, 4, movetoworkspace, 4"
        "$MOD SHIFT, 5, movetoworkspace, 5"
        "$MOD SHIFT, 6, movetoworkspace, 6"
        "$MOD SHIFT, 7, movetoworkspace, 7"
        "$MOD SHIFT, 8, movetoworkspace, 8"
        "$MOD SHIFT, 9, movetoworkspace, 9"

        # Scroll through workspace
        "SUPER,mouse_down,workspace,e+1"
        "SUPER,mouse_up,workspace,e-1"

        # Misc
        ", F11, exec, hyprctl dispatch fullscreen"
        "$MOD SHIFT, P, exec, ~/.config/scripts/hyprland/window-pin.sh"
        "$MOD SHIFT, W, exec, ~/.config/scripts/hyprland/switchwall.sh"

        # Group bindings
        "$MOD,g,togglegroup"
        "$MOD,tab,changegroupactive"
      ];
      bindel = [
        # Brightness Control
        ", XF86MonBrightnessUp, exec, ~/.config/scripts/hyprland/brightness.sh up"
        ", XF86MonBrightnessDown, exec, ~/.config/scripts/hyprland/brightness.sh down"
        "SHIFT, XF86MonBrightnessUp, exec, ~/.config/scripts/hyprland/brightness.sh up1"
        "SHIFT, XF86MonBrightnessDown, exec, ~/.config/scripts/hyprland/brightness.sh down1"

        # Audio Control
        " , XF86AudioMute, exec, ~/.config/scripts/hyprland/volume.sh toggleMute"
        " , XF86AudioMicMute, exec, pamixer --default-source -t"
        ", XF86AudioRaiseVolume, exec, ~/.config/scripts/hyprland/volume.sh up"
        ", XF86AudioLowerVolume, exec, ~/.config/scripts/hyprland/volume.sh down"
      ];
      bindl = [
        # Media Control
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl play-stop"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"

        # DND Toggle
        "$MOD, N, exec, dunstctl close"
        "$MOD SHIFT, N, exec, dunstctl close-all"
        "$MOD SHIFT, D, exec, dunstctl set-paused toggle"
      ];
      bindm = [
        # Resize and Move
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];
    };
  };
  wayland.windowManager.hyprland.extraConfig = ''
    # will switch to a submap called resize
    bind = $ALT, R, submap, resize

    # will start a submap called "resize"
    submap = resize

    # sets repeatable binds for resizing the active window
    binde = , H, resizeactive, -10 0
    binde = , J, resizeactive, 0 10
    binde = , K, resizeactive, 0 -10
    binde = , L, resizeactive, 10 0

    # use reset to go back to the global submap
    bind = , escape, submap, reset

    # will reset the submap, meaning end the current one and return to the global one
    submap = reset
  '';
}


