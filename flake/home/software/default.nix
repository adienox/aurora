{
  config,
  pkgs,
  inputs,
  ...
}:
{
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
    gnome-clocks
    gnome-calculator
    gnome.gvfs
    nautilus
    keepassxc
    telegram-desktop
    qpwgraph
    qbittorrent
    inputs.anipy-cli.packages.${pkgs.system}.default
    ookla-speedtest
    termshark
    protonmail-bridge
    isync
  ];

  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
    mbsync = {
      enable = true;
      extraConfig = ''
        IMAPAccount proton
        Host 127.0.0.1
        Port 1143
        User adwait@adhk.dev
        PassCmd "${pkgs.coreutils}/bin/cat ${config.xdg.configHome}/sops-nix/secrets/pass/protonmail-bridge"
        TLSType STARTTLS
        CertificateFile ${config.xdg.configHome}/protonmail/cert.pem

        IMAPStore proton-remote
        Account proton

        MaildirStore proton-local
        Subfolders Verbatim
        Path ~/Mail/proton/
        Inbox ~/Mail/proton/Inbox

        Channel proton
        Far :proton-remote:
        Near :proton-local:
        Create Both
        Expunge Both
        Patterns *
        SyncState *
      '';
    };
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
