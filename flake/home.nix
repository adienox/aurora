{ config, pkgs, ... }: {

  imports = [
    ./config/git.nix
    ./config/theme.nix
    ./modules/hyprland.nix
    ./modules/shell.nix
  ];

  home.username = "nox";
  home.homeDirectory = "/home/nox";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    todoist-electron
    calibre
    brave
    kitty
    mpv
    pavucontrol
    morgen
    obsidian
    cava
    keepassxc
    telegram-desktop
    qpwgraph
    libtool
    yt-dlp
    pulsemixer
    imv
    discord
  ];

  nixpkgs.overlays = [ (final: prev: {
      discord = prev.discord.override {
        withOpenASAR = true;
        withVencord = true;
      };
  }) ];
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

  services = {
    syncthing.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  fonts = { fontconfig.enable = true; };

  programs.home-manager.enable = true;
}
