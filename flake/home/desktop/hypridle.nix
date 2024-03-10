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

  suspend-script = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    # only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  services.hypridle = {
    enable = true;
    beforeSleepCmd = hyprlock;
    lockCmd = hyprlock;
    listeners = [
      {
        timeout = 300;
        onTimeout = "${brightness-fade}/bin/brightness-fade fade";
        onResume = "${brightness-fade}/bin/brightness-fade resume";
      }
      {
        timeout = 500;
        onTimeout = hyprlock;
      }
      {
        timeout = 600;
        onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
