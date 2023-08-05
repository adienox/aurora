{ config, lib, pkgs, ... }: {
  imports = [
    ./hyprland
    ./swayidle.nix
    ./swww.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    swww
    swayidle
    gtklock
    qt5.qtwayland
    libsForQt5.qt5ct
    libsForQt5.lightly
    qt6.qmake
    qt6.qtwayland
    grim
    slurp
    pamixer
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
}