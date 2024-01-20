{ config, pkgs, ... }: {
  imports = [
    ./media
    ./browser
    ./discord.nix
    ./git.nix
    ./xremap.nix
    # ./webcord.nix
    # ./dunst.nix
  ];

  home.packages = with pkgs; [
    amberol
    todoist
    anki-bin
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome.nautilus
    morgen
    obsidian
    keepassxc
    telegram-desktop
    qpwgraph
    qbittorrent
    maestral
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
  };
}
