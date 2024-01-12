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
    package = inputs.hyprland-31.legacyPackages.${pkgs.system}.hyprland;
    xwayland = { enable = true; };
  };

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy =
    lib.mkForce [ "hyprland-session.target" ];

  systemd.user.services.wlsunset = {
    Unit = {
      Description = "NightTemp";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wlsunset}/bin/wlsunset -t 5000 -S 8:00 -s 19:30";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
