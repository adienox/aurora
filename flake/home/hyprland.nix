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
    gtklock
    udiskie
    bibata-cursors
    networkmanagerapplet
    acpi
    playerctl
    noto-fonts-cjk-sans
    qt5.qtwayland
    libsForQt5.qt5ct
    libsForQt5.lightly
    qt6.qmake
    qt6.qtwayland
    xdg-user-dirs
    eww-wayland
  ];

  fonts.fontconfig.enable = true;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
}
