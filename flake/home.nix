{ config, pkgs, ... }:

{
  imports = [
    ./config/git.nix
    ./config/theme.nix
  ];
  home.username = "nox";
  home.homeDirectory = "/home/nox";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    mindustry-wayland
    pfetch
    wl-clipboard
    todoist-electron
    calibre
    swww
    ispell
    dunst
    brave
    blueman
    brightnessctl
    kitty
    mpv
    pavucontrol
    qt6.qmake
    qt5.qtwayland
    qt6.qtwayland
    trash-cli
    tldr
    scrot
    rofi-wayland
    ripgrep
    starship
    zoxide
    papirus-icon-theme
    morgen
    obsidian
    swayidle
    swaylock-effects
    unzip
    udiskie
    bibata-cursors
    libsForQt5.qt5ct
    libsForQt5.lightly
    cava
    keepassxc
    networkmanagerapplet
    bat
    dolphin
    cmake
    gnumake
    gcc
    telegram-desktop
    qpwgraph
    pulsemixer
    libnotify
    nodejs
    pamixer
    jq
    libtool
    exa
    tmux
    acpi
    fd
    yt-dlp
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.desktopEntries.keepassxc = {
    name = "KeepassXC (XCB)";
    genericName = "Password Manager";
    icon = "keepassxc";
    exec = "keepassxc -platform xcb %f";
    terminal = false;
    categories = [ "Utility" "Security" ];
    mimeType = [ "application/x-keepass2" ];
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };

  services = {
    syncthing.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  fonts = {
    fontconfig.enable = true;
  };

  programs.home-manager.enable = true;
}
