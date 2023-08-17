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
    neovim
    todoist-electron
    amberol
    anki-bin
    gnome.gnome-clocks
    gnome.gnome-calculator
    calibre
    morgen
    obsidian
    keepassxc
    telegram-desktop
    qpwgraph
    libtool
    wezterm
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
  };
}
