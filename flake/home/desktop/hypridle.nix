{ pkgs, inputs, ... }:
let
  hyprlock = "${inputs.hyprlock.packages.${pkgs.system}.hyprlock}/bin/hyprlock";

  brightness-fade = (pkgs.writeShellApplication {
    name = "brightness-fade";
    runtimeInputs = with pkgs; [
      coreutils
      brightnessctl
      bash
      pipewire
      ripgrep
    ];
    text = builtins.readFile ../../../assets/scripts/hyprland/fade.sh;
  });
in {
  services.hypridle = {
    enable = true;
    beforeSleepCmd = hyprlock;
    lockCmd = hyprlock;
    listeners = [
      {
        timeout = 300;
        onTimeout = "${brightness-fade}/bin/brightness-fade";
        onResume = "${brightness-fade}/bin/brightness-fade";
      }
      {
        timeout = 500;
        onTimeout = hyprlock;
      }
    ];
  };
}
