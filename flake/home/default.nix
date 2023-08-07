{ config, pkgs, inputs, ... }: {

  imports = [
    ./shell
    ./desktop
    ./editors
    ./terminal
    ./theme
    ./software
  ];

  home.username = "nox";
  home.homeDirectory = "/home/nox";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    todoist-electron
    amberol
    anki-bin
    gnome.gnome-clocks
    gnome.gnome-calculator
    calibre
    brave
    morgen
    obsidian
    keepassxc
    telegram-desktop
    qpwgraph
    libtool
    yt-dlp
    pulsemixer
    jetbrains.idea-community
    inputs.nh.packages.${pkgs.system}.default
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
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  programs = {
    librewolf.enable = true;
    home-manager.enable = true;
  };
}
