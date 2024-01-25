{ lib, pkgs, inputs, ... }: {
  imports = [ ./config.nix ];
  home.packages = with pkgs; [
    udiskie # AutoMount disks
    bibata-cursors # Mouse Cursor
    networkmanagerapplet # NetworkManager
    gojq # For wallpaper setting utility
    xorg.xrandr # For wallpaper setting utility
    yad # Picker
    gnome.zenity # Another picker
    xwaylandvideobridge # Xwayland screen share
    wl-clipboard # Clipboard

    # recorder and screenshot
    grim
    slurp
    tesseract # ocr
    wf-recorder

    # Hyprland requirement
    libsForQt5.qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland-31.legacyPackages.${pkgs.system}.hyprland;
    xwayland = { enable = true; };
  };

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy =
    lib.mkForce [ "hyprland-session.target" ];
}
