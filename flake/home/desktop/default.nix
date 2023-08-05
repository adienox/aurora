{ config, lib, pkgs, ... }: {
  imports = [
    ./hyprland
    ./swayidle.nix
    ./swww.nix
    ./espanso.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    gtklock
    libsForQt5.qt5.qtwayland
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

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}