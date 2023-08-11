{ config, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        # Floating Rules
        "float, title:^(fly_is_kitty)$"
        "float, title:^(clock_is_kitty)$"
        "float, title:^(Unlock Database - KeePassXC)$"
        "float, ^(org\.kde\.polkit-kde-authentication-agent-1)$"
        "float, title:^(firewall-applet)$"
        "float, title:^(all_is_kitty)$"
        "float, title:^(KeePassXC - Browser Access Request)$"
        "float, ^(blueman-manager)$"
        "float, title:^(Discord Popout)$"
        "float, title:^(Picture in picture)$"
        "float, title:^(Volume Control)$"
        "float, title:^(Picture-in-Picture)$"
        "float, title:^(LibreWolf — Sharing Indicator)$"
        "float, yad"
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
        "float, ^(io\.bassi\.Amberol)$"
        "float, ^(org\.gnome\.Calculator)$"

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
        "animation popin, floating:1"
        "animation popin, yad"
        "animation popin, title:^(fly_is_kitty)$"
        "animation popin, title:^(Discord Popout)$"
        "animation popin, title:^(Picture in picture)$"
        "animation popin, title:^(Picture-in-Picture)$"

        # Workspace Rules
        "workspace 1, ^(Brave-browser)$"
        "workspace 1, ^(librewolf)$"
        "workspace 2, ^(Emacs)$"
        "workspace 2, ^(Code)$"
        "workspace 3, ^(obsidian)$"
        "workspace 4, ^(calibre-gui)$"
        "workspace 5, ^(discord)$"
        "workspace 5, ^(org\.telegram\.desktop)$"
        "workspace 6, ^(Todoist)$"
        "workspace 7, ^(Spotify)$"
        "workspace 8, ^(Morgen)$"

        # Fullscreen Rules
        "fullscreen, ^(obsidian)$"
        "fullscreen, ^(Todoist)$"
        "fullscreen, ^(Morgen)$"

        # Misc rules
        "idleinhibit focus, mpv"
        "idleinhibit focus, ^(discord)$"
        "rounding 4, title:^(LibreWolf — Sharing Indicator)$"
      ];
      windowrulev2 = [
        "idleinhibit fullscreen, class:^(librewolf)$"
        "idleinhibit focus, class:^(librewolf)$, title:^(.*YouTube.*)$"
        "noshadow, floating:0"

        "opacity 0.80 0.70,class:^(pavucontrol)$"
        "opacity 0.80 0.70,class:^(yad)$"
        "opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$"
        "opacity 0.80 0.70,title:^(Discord Popout)$"
        "noborder,title:^(Discord Popout)$"

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
        "blur, notifications"
        "ignorealpha 0.69, notifications"
        "blur, rofi"
        "ignorealpha 0.5, rofi"
        "blur, gtk-layer-shell"
        "ignorezero, gtk-layer-shell"
      ];
    };
  };
}
