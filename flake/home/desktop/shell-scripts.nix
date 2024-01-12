{ pkgs, ... }:
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
  };
}
