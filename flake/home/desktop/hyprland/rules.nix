{ default, ... }:
{
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
        "float, ^(org.pwmt.zathura)"
        "float, ^(imv)"
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
        "move 1285 715, title:^(Picture in picture)$"
        "move 1285 715, title:^(Picture-in-Picture)$"
        "move 560 290, title:^(fly_is_kitty)$"

        "size 485 300, title:^(Discord Popout)$"
        "size 630 360, title:^(Picture in picture)$"
        "size 630 360, title:^(Picture-in-Picture)$"
        "size 800 500, ^(floating)$"
        "size 800 500, ^(imv)$"

        # Animation Rules
        "animation popin, title:^(Discord Popout)$"
        "animation popin, title:^(Picture in picture)$"
        "animation popin, title:^(Picture-in-Picture)$"

        # Workspace Rules
        "workspace 1, ^(firefox)$"
        "workspace 2, ^(Emacs)$"
        "workspace 2, ^(emacs)$"
        "workspace 2, ^(Code)$"
        "workspace 3, ^(kitty)$"
        "workspace 3, ^(mpv)$"
        "workspace 3, ^(org.pwmt.zathura)$"
        "workspace 3, ^(calibre-gui)$"
        "workspace 4, ^(org.telegram.desktop)$"
        "workspace 5, ^(discord)$"
        "workspace 5, ^(vesktop)$"
        "workspace 6, ^(Todoist)$"
        "workspace 7, ^(Spotify)$"
        "workspace 8, ^(Morgen)$"
        "workspace 8, ^(xwaylandvideobridge)$"
        "workspace 9, ^(org.rncbc.qpwgraph)$"

        # Fullscreen Rules
        "fullscreen, obsidian"
        "fullscreen, ^(Emacs)"
        "fullscreen, ^(emacs)"
        "fullscreen, ^(mpv)$"
        "fullscreen, Morgen"
        "fullscreen, ^(org.pwmt.zathura)$"
      ];
      windowrulev2 = [
        # Utils
        "noshadow, floating:0"
        "animation popin, floating:1"

        # centering
        "center, class:^(firefox)$, title:^(Enter name of file to save to…)$"
        "center, class:^(floating)$"
        "center, class:^(imv)$"

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

        "opacity 0.8, class:^(obsidian)$"
        "opacity 0.9, class:^(ticktick)$"
        "opacity 0.9, class:^(Anki)$"
        "opacity 0.9, class:^(calibre-gui)$"

        # Focus Rules
        "noinitialfocus, title:^(Picture-in-Picture)$"
        "noinitialfocus, title:^(Picture in Picture)$"

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

        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
        "1, monitor:eDP-1, default:true"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "5, monitor:HDMI-A-1, default:true"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1"
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
