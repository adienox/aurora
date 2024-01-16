{ ... }: {
  wayland.windowManager.hyprland = {

    settings = {
      "$MOD" = "SUPER";
      "$ALT" = "ALT";
      "$SCRIPTS" = "~/.config/assets/scripts/hyprland";
      "$TERM" = "wezterm start";
      "$FLOATING_TERM" = "wezterm start --class floating -e";

      bind = [
        # Term
        "$MOD, RETURN, exec, $TERM"
        "$MOD SHIFT, RETURN, exec, kitty --start-as=fullscreen -o 'font_size=16' --title all_is_kitty"

        # Alt Term
        "$ALT, RETURN, exec, $FLOATING_TERM zsh"
        "$ALT, 1, exec, $FLOATING_TERM cava"
        "$ALT, 2, exec, $FLOATING_TERM pulsemixer"
        "$ALT, 3, exec, $FLOATING_TERM newsboat"

        # Applications
        "$MOD, W, exec, $SCRIPTS/focus.sh Vivaldi-stable vivaldi"
        "$MOD, O, exec, $SCRIPTS/focus.sh obsidian obsidian"
        "$MOD, M, exec, $SCRIPTS/focus.sh Morgen morgen"
        "$MOD, E, exec, $SCRIPTS/focus.sh Code 'code --enable-features=UseOzonePlatform --ozone-platform=wayland'"
        "$MOD, S, exec, $SCRIPTS/focus.sh Spotify spotify"
        "$MOD, X, exec, wlogout -p layer-shell"

        # Rofi
        "$MOD, B, exec, $SCRIPTS/rofi.sh bluetooth"
        "$MOD, Y, exec, $SCRIPTS/rofi.sh rofi-beats"
        "$ALT, P, exec, keepmenu"
        "CTRL, code:47, exec, $SCRIPTS/rofi.sh obsidian-log"
        "SHIFT, Insert, exec, $SCRIPTS/rofi.sh obsidian-log-with-screenshot"
        "$MOD, I, exec, $SCRIPTS/rofi.sh emoji"
        "$MOD, T, exec, $SCRIPTS/rofi.sh todoist"
        "$MOD, Space, exec, $SCRIPTS/rofi.sh drun"
        "$ALT, Space, exec, $SCRIPTS/rofi.sh calc"
        "$ALT, Tab, exec, $SCRIPTS/rofi.sh window"

        # Clipboard
        "$MOD, V, exec, $SCRIPTS/rofi.sh clipboard"
        "$MOD SHIFT, V, exec, cliphist wipe"

        # Hyprland Bindings
        "$MOD SHIFT, Q, killactive, "
        "$MOD, F, togglefloating, "
        "$MOD, P, pseudo,"

        # Screenshot
        ", Print, exec, $SCRIPTS/screenshot.sh full"
        "SHIFT, Print, exec, $SCRIPTS/screenshot.sh partial"
        "$MOD SHIFT, T, exec, $SCRIPTS/screenshot.sh ocr"

        # Recording
        "$MOD, R, exec, $SCRIPTS/screenrecord.sh"

        # Scroll through workspace
        "SUPER,mouse_down,workspace,e+1"
        "SUPER,mouse_up,workspace,e-1"

        # Misc
        ", F11, exec, hyprctl dispatch fullscreen"
        "$MOD SHIFT, P, exec, $SCRIPTS/window-pin.sh"
        "$MOD SHIFT, W, exec, $SCRIPTS/switchwall.sh"
        "$MOD, C, exec, hyprctl dispatch centerwindow"

        # Group bindings
        "$MOD,g,togglegroup"
        "$MOD,tab,changegroupactive"

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
      ];

      bindel = [
        # Brightness Control
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
        "SHIFT, XF86MonBrightnessUp, exec, swayosd-client --brightness 1"
        "SHIFT, XF86MonBrightnessDown, exec, swayosd-client --brightness -1"

        # Audio Control
        ", XF86AudioMute, exec, swayosd-client --output-volume=mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume=mute-toggle"
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume=raise --max-volume=150"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume=lower --max-volume=150"
      ];

      bindl = [
        # Media Control
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl play-stop"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"

        # Notification
        "$MOD, N, exec, swaync-client --close-latest"
        "$MOD SHIFT, N, exec, swaync-client -t"
        "$MOD SHIFT, D, exec, swaync-client -d"
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
