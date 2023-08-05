{ config, pkgs, ... }: {
  imports = [ ./config.nix ];
  home.packages = with pkgs; [
    dunst
    libnotify
    blueman
    brightnessctl
    rofi-wayland
    udiskie
    bibata-cursors
    networkmanagerapplet
    acpi
    playerctl
    noto-fonts-cjk-sans
    xdg-user-dirs
    dconf
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
}
