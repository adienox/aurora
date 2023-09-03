{ config, pkgs, ... }: {
  imports = [
    ./dunst.nix
    ./discord.nix
    ./media.nix
    ./git.nix
    ./librewolf.nix
    ./webcord.nix
  ];

  home.packages = with pkgs; [
    brave
    todoist-electron
    amberol
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
    wezterm
    qbittorrent
    ytfzf
    mindustry-wayland
  ];

  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
    };

    syncthing.enable = true;

    kdeconnect = {
      enable = true;
      indicator = true;
    };

    swayosd = {
      enable = true;
      maxVolume = 150;
    };
  };
}
