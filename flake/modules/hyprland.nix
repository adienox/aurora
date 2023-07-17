{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    jq
    wl-clipboard
    swww
    dunst
    libnotify
    blueman
    brightnessctl
    rofi-wayland
    grim
    slurp
    pamixer
    papirus-icon-theme
    swayidle
    swaylock-effects
    udiskie
    bibata-cursors
    networkmanagerapplet
    acpi
    qt5.qtwayland
    libsForQt5.qt5ct
    libsForQt5.lightly
    qt6.qmake
    qt6.qtwayland
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
}
