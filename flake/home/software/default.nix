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
    ./glance.nix
    # ./webcord.nix
    # ./dunst.nix
  ];

  home.packages = with pkgs; [
    calibre
    anki-bin
    amberol
    ticktick
    gnome-clocks
    gnome-calculator
    gnome.gvfs
    nautilus
    obsidian
    keepassxc
    telegram-desktop
    qpwgraph
    qbittorrent
    inputs.anipy-cli.packages.${pkgs.system}.default
    ookla-speedtest
    termshark
    fabric-ai
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

    pueue = {
      enable = true;
      settings = {
        daemon = {
          default_parallel_tasks = 3;
        };
      };
    };

    syncthing.enable = true;
    kdeconnect.enable = true;
  };
}
