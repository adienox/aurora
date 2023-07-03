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
    dunst
    emacs
    brave
    blueman
    brightnessctl
    kitty
    mpv
    neofetch
    pavucontrol
    qt5.qtwayland
    qt6.qmake
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
    udiskie
    bibata-cursors
    libsForQt5.qt5ct
    libsForQt5.lightly
    cava
    keepassxc
    networkmanagerapplet
    bat
    dolphin
    hanazono
    cmake
    gnumake
    gcc
    discord
    betterdiscord-installer
    telegram-desktop
    qpwgraph
    pulsemixer
    libnotify
    nodejs
    pamixer
    jq
    catppuccin-gtk
    libtool
    exa
    tmux
    acpi
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

  services = {
    syncthing.enable = true;
  };

  fonts = {
    fontconfig.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "emacsclient";
  };

  programs.home-manager.enable = true;
}
