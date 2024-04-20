{ config, pkgs, ... }:
let
  battery-status = (pkgs.writeShellApplication {
    name = "battery-status";
    runtimeInputs = with pkgs; [
      coreutils
      gnugrep
      gawk
      acpi
      sox
      swaynotificationcenter
      libnotify
    ];
    text = builtins.readFile ../../../assets/scripts/hyprland/battery-status.sh;
  });

  bluetooth-auto-off = (pkgs.writeShellApplication {
    name = "bluetooth-auto-off";
    runtimeInputs = with pkgs; [ coreutils gawk bluez ];
    text =
      builtins.readFile ../../../assets/scripts/hyprland/bluetooth-auto-off.sh;
  });

  mako-reload = (pkgs.writeShellApplication {
    name = "mako-reload";
    runtimeInputs = with pkgs; [ mako libnotify ];
    text = builtins.readFile ../../../assets/scripts/utils/mako-reload.sh;
  });

  play-with-mpv = (pkgs.writeShellApplication {
    name = "play-with-mpv-wrapper";
    runtimeInputs = with pkgs; [ yt-dlp mpv ];
    text = ''
      ${pkgs.play-with-mpv}/bin/play-with-mpv
    '';
  });
in {
  systemd.user.services = {
    battery-status = {
      Unit = {
        Description = "Battery status script";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${battery-status}/bin/battery-status";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    bluetooth-auto-disable = {
      Unit = {
        Description = "Auto disable bluetooth if no device connected";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${bluetooth-auto-off}/bin/bluetooth-auto-off";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    play-with-mpv = {
      Unit = {
        Description = "Server component for play-with-mpv extension";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${play-with-mpv}/bin/play-with-mpv-wrapper";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    mako-reload = {
      Unit = {
        Description = "Mako config reloader";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${mako-reload}/bin/mako-reload";
        Type = "oneshot";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.paths = {
    mako-reload = {
      Unit = {
        Description = "Mako config reloader";
        PartOf = [ "graphical-session.target" ];
      };
      Path = { PathModified = "%h/.config/mako/config"; };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
