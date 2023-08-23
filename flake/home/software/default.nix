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

    # ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
    # ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
    swayosd = {
      enable = true;
      maxVolume = 150;
    };
  };
}
