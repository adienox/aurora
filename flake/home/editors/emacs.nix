{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    cmake
    gnumake

    gcc
    ripgrep
    fd
    libtool
    ispell

    # nix stuff
    nixfmt-rfc-style
    nixd

    # bash stuff
    bash-language-server

    # go stuff
    go
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages =
      epkgs: with epkgs; [
        pdf-tools
      ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    startWithUserSession = "graphical";
  };

  home.sessionPath = [
    "${config.xdg.configHome}/emacs/bin"
  ];
}
