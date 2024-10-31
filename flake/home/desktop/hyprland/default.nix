{
  pkgs,
  inputs,
  ...
}: {
  imports = [./config.nix];
  home.packages = with pkgs; [
    udiskie # AutoMount disks
    bibata-cursors # Mouse Cursor
    networkmanagerapplet # NetworkManager
    gojq # For wallpaper setting utility
    xorg.xrandr # For wallpaper setting utility
    yad # Picker
    zenity # Another picker
    wl-clipboard # Clipboard
    socat
    # ianny # tells you to take breaks

    # recorder and screenshot
    grim
    slurp
    tesseract # ocr
    wf-recorder

    # Hyprland requirement
    libsForQt5.qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    inputs.pyprland.packages."x86_64-linux".pyprland
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland = {enable = true;};
  };
}
