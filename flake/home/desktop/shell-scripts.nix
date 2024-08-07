{pkgs, ...}: let
  battery-status = pkgs.writeShellApplication {
    name = "battery-status";
    runtimeInputs = with pkgs; [
      coreutils
      gnugrep
      gawk
      acpi
      sox
      libnotify
    ];
    text = builtins.readFile ../../../assets/scripts/hypr/battery-status.sh;
  };

  bluetooth-auto-off = pkgs.writeShellApplication {
    name = "bluetooth-auto-off";
    runtimeInputs = with pkgs; [coreutils gawk bluez];
    text =
      builtins.readFile ../../../assets/scripts/hypr/bluetooth-auto-off.sh;
  };

  play-with-mpv = pkgs.writeShellApplication {
    name = "play-with-mpv-wrapper";
    runtimeInputs = with pkgs; [yt-dlp mpv];
    text = ''
      ${pkgs.play-with-mpv}/bin/play-with-mpv
    '';
  };
in {
  systemd.user.services = {
    battery-status = {
      Unit = {
        Description = "Battery status script";
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${battery-status}/bin/battery-status";
        Restart = "on-failure";
      };
      Install.WantedBy = ["graphical-session.target"];
    };

    bluetooth-auto-disable = {
      Unit = {
        Description = "Auto disable bluetooth if no device connected";
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${bluetooth-auto-off}/bin/bluetooth-auto-off";
        Restart = "on-failure";
      };
      Install.WantedBy = ["graphical-session.target"];
    };

    play-with-mpv = {
      Unit = {
        Description = "Server component for play-with-mpv extension";
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${play-with-mpv}/bin/play-with-mpv-wrapper";
        Restart = "on-failure";
      };
      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
