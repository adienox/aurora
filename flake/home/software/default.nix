{ config, pkgs, ... }: {
  imports = [
    # ./dunst.nix
    ./media
    ./browser
    ./discord.nix
    ./git.nix
    ./webcord.nix
    ./xremap.nix
    # ./schizofox.nix
  ];

  home.packages = with pkgs; [
    amberol
    todoist
    todoist-electron
    anki-bin
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome.nautilus
    calibre
    morgen
    obsidian
    keepassxc
    telegram-desktop
    qpwgraph
    qbittorrent
    maestral
    vivaldi
    koreader
    wireshark
  ];

  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
    };

    syncthing.enable = true;

    # kdeconnect = {
    #   enable = true;
    #   indicator = true;
    # };

    swayosd = {
      enable = true;
      maxVolume = 150;
    };
  };
}
