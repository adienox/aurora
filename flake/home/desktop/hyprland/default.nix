{ lib, pkgs, inputs, ... }: {
  imports = [ ./config.nix ];
  home.packages = with pkgs; [
    udiskie # AutoMount disks
    bibata-cursors # Mouse Cursor
    networkmanagerapplet # NetworkManager
    acpi # Battery status
    gojq # For wallpaper setting utility
    xorg.xrandr # For wallpaper setting utility
    yad # Picker
    xwaylandvideobridge # Xwayland screen share
    wl-clipboard # Clipboard
    wlsunset # Screen temp

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
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland = { enable = true; };
  };

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy =
    lib.mkForce [ "hyprland-session.target" ];
}
