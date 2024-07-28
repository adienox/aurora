{
  config,
  pkgs,
  inputs,
  ...
}: {
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
    calibre
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
    inputs.anipy-cli.packages.${pkgs.system}.default
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
    kdeconnect.enable = true;
  };
}
