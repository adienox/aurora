{config, lib, pkgs, hyprland, ... }: {
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
  package = hyprland.packages.${pkgs.system}.hyprland;
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

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];
}
