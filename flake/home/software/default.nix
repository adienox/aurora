{ config, pkgs, ... }:
let
  custom_mech = pkgs.python311Packages.mechanize.overridePythonAttrs
    (old: { doCheck = false; });
  custom_calibre = pkgs.calibre.override (old: {
    python3Packages = old.python3Packages // { mechanize = custom_mech; };
  });
in {
  imports = [
    ./media
    ./browser
    ./discord.nix
    ./git.nix
    ./xremap.nix
    ./webcord.nix
    # ./dunst.nix
  ];

  home.packages = with pkgs; [
    custom_calibre
    anki-bin
    amberol
    ticktick
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome.nautilus
    obsidian
    keepassxc
    telegram-desktop
    qpwgraph
    qbittorrent
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
      pinentryPackage = pkgs.pinentry.gnome3;
    };

    syncthing.enable = true;
  };
}
