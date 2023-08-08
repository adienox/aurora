{ config, lib, pkgs, inputs, ... }: {
  imports = [ ./config.nix ];
  home.packages = with pkgs; [
    brightnessctl
    rofi-wayland
    udiskie
    bibata-cursors
    networkmanagerapplet
    acpi
    noto-fonts-cjk-sans
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland = {
      enable = true;
      hidpi = true;
    };
  };

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];
}