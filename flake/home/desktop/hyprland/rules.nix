{default, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        # Floating Rules
        "float, title:^(fly_is_kitty)$"
        "float, title:^(Unlock Database - KeePassXC)$"
        "float, title:^(firewall-applet)$"
        "float, title:^(all_is_kitty)$"
        "float, title:^(KeePassXC - Browser Access Request)$"
        "float, title:^(Discord Popout)$"
        "float, title:^(Picture in picture)$"
        "float, title:^(Volume Control)$"
        "float, title:^(Picture-in-Picture)$"
        "float, title:^(LibreWolf — Sharing Indicator)$"
        "float, yad"
        "float, floating"
        "float, udiskie"
        "float, file_progress"
        "float, confirm"
        "float, dialog"
        "float, download"
        "float, notification"
        "float, error"
        "float, splash"
        "float, confirmreset"
        "float, title:Open File"
        "float, title:branchdialog"
        "float, feh"
        "float, pavucontrol-qt"
        "float, pavucontrol"
        "float, file-roller"
        "float, title:DevTools"
        "float, title:wlogout"
        "float, ^(blueman-manager)$"
        "float, ^(io.bassi.Amberol)$"
        "float, ^(org.gnome.Calculator)$"
        "float, ^(org.gnome.clocks)$"
        "float, ^(org.kde.polkit-kde-authentication-agent-1)$"

        #Size, Move, and Pin rules
        "pin, title:^(Picture in picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "pin, title:^(Discord Popout)$"

        "move 1430 45, title:^(Discord Popout)$"
        "move 1430 770, title:^(Picture in picture)$"
        "move 1430 770, title:^(Picture-in-Picture)$"
        "move 560 290, title:^(fly_is_kitty)$"

        "size 485 300, title:^(Discord Popout)$"
        "size 485 300, title:^(Picture in picture)$"
        "size 485 300, title:^(Picture-in-Picture)$"
        "size 800 500, title:^(fly_is_kitty)$"

        # Animation Rules
        "animation popin, title:^(Discord Popout)$"
        "animation popin, title:^(Picture in picture)$"
        "animation popin, title:^(Picture-in-Picture)$"

        # Workspace Rules
        "workspace 1, ^(firefox)$"
        "workspace 2, ^(kitty)$"
        "workspace 2, ^(Emacs)$"
        "workspace 2, ^(Code)$"
        "workspace 4, ^(mpv)$"
        "workspace 4, ^(calibre-gui)$"
        "workspace 5, ^(discord)$"
        "workspace 5, ^(org.telegram.desktop)$"
        "workspace 6, ^(Todoist)$"
        "workspace 7, ^(Spotify)$"
        "workspace 8, ^(Morgen)$"
        "workspace 8, ^(xwaylandvideobridge)$"
        "workspace 9, ^(org.rncbc.qpwgraph)$"

        # Fullscreen Rules
        "fullscreen, obsidian"
        "fullscreen, ^(mpv)$"
        "fullscreen, Morgen"
      ];
      windowrulev2 = [
        # Utils
        "noshadow, floating:0"
        "animation popin, floating:1"

        # centering
        "center, class:^(firefox)$, title:^(Enter name of file to save to…)$"

        # Idle inhibit rules
        "idleinhibit fullscreen, class:^(librewolf)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "idleinhibit focus, class:^(ticktick)$"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit focus, class:^(discord)$"
        "idleinhibit focus, class:^(Vivaldi-stable)$, title:(.*)(- Youtube)(.*)$"

        # Opacity Rules
        "opacity ${default.settings.floating_opacity}, floating:1"

        "opacity ${default.settings.opacity}, class:^(Spotify)$"
        "opacity ${default.settings.opacity}, class:^(org.gnome.Nautilus)$"
        "opacity ${default.settings.opacity}, class:^(org.telegram.desktop)$"
        "opacity ${default.settings.opacity}, class:^(discord)$"
        "opacity ${default.settings.opacity}, class:^(io.bassi.Amberol)$"

        "opacity 1, class:^(floating)$"
        "opacity 1, class:^(Vivaldi-stable)$"
        "opacity 1, class:^(discord), fullscreen:1"

        "opacity 0.9, class:^(obsidian)$"
        "opacity 0.9, class:^(ticktick)$"
        "opacity 0.9, class:^(Anki)$"
        "opacity 0.9, class:^(calibre-gui)$"

        "tile, class:^(Vivaldi-stable)$"
        "float, class:^(Anki)$, title:^(Add)$"
        "center, class:^(Anki)$, title:^(Add)$"
        "float, class:^(Anki)$, title:^(Preferences)$"
        "center, class:^(Anki)$, title:^(Preferences)$"

        # Wlogout
        "noanim, class:^(wlogout)$, title:^(wlogout)$"
        "noshadow, class:^(wlogout)$, title:^(wlogout)$"

        # XWaylandVideoBridge
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "noshadow,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
      ];
      layerrule = [
        "blur, rofi"
        "ignorezero, rofi"

        "animation popin 50%, rofi"
        "animation slide, waybar"
        "noanim, swww"
        "blur, logout_dialog"

        "blur, waybar"
        "ignorezero, waybar"
        "xray 1, waybar"
        "ignorealpha 0.39, waybar"

        "blur, notifications"
        "ignorezero, notifications"

        "blur, gtk-layer-shell"
        "ignorezero, gtk-layer-shell"

        "blur, swaync-control-center"
        "ignorezero, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorezero, swaync-notification-window"
      ];
    };
  };
}
