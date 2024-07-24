{pkgs, ...}: let
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";

  brightness-fade = pkgs.writeShellApplication {
    name = "brightness-fade";
    runtimeInputs = with pkgs; [
      coreutils
      brightnessctl
      bash
      pipewire
      ripgrep
    ];
    text = builtins.readFile ../../../assets/scripts/hyprland/fade.sh;
  };

  suspend-script = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.playerctl}/bin/playerctl -a metadata -f "{{status}}" | ${pkgs.ripgrep}/bin/rg "Playing"
    # only suspend if audio isn't running and no other user is logged in
    if [ $? == 1 ] && [ "$(who | wc -l)" -eq 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  services.hypridle = {
    enable = true;
    settings = {
      before_sleep_cmd = hyprlock;
      after_sleep_cmd = hyprlock;
      lock_cmd = hyprlock;
      listener = [
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
          # onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
          onTimeout = "${suspend-script}";
        }
      ];
    };
  };
}
