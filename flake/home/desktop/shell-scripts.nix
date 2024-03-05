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

  auto-stats = (pkgs.writeShellApplication {
    name = "auto-stats-wrapper";
    runtimeInputs = with pkgs; [ python3 rofi-wayland ];
    text = ''
      python3 ${config.xdg.configHome}/assets/scripts/rofi/auto-stats.py
    '';
  });

  auto-stats-processor = (pkgs.writeShellApplication {
    name = "auto-stats-processor-wrapper";
    runtimeInputs = with pkgs; [ python3 ];
    text = ''
      python3 ${config.xdg.configHome}/assets/scripts/rofi/auto-stats-processor.py
    '';
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

    # auto-stats = {
    #   Unit = {
    #     Description = "Auto ask for stats used in obsidian daily log";
    #     PartOf = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${auto-stats}/bin/auto-stats-wrapper";
    #     Restart = "on-failure";
    #   };
    #   Install.WantedBy = [ "graphical-session.target" ];
    # };
    #
    # auto-stats-processor = {
    #   Unit = {
    #     Description = "Process auto-stats used in obsidian daily log";
    #     PartOf = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${auto-stats-processor}/bin/auto-stats-processor-wrapper";
    #     Restart = "on-failure";
    #   };
    #   Install.WantedBy = [ "graphical-session.target" ];
    # };

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
  };

  # systemd.user.timers = {
  #   auto-stats = {
  #     Unit = { Description = "Run auto-stats every 20 mins"; };
  #     Timer = { OnCalendar = "*-*-* 06..17:00/20"; };
  #     Install.WantedBy = [ "timers.target" ];
  #   };
  #
  #   auto-stats-processor = {
  #     Unit = { Description = "Process the auto-stats for the day"; };
  #     Timer = { OnCalendar = "*-*-* 18:30"; };
  #     Install.WantedBy = [ "timers.target" ];
  #   };
  # };
}
