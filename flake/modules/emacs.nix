{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    ispell
    nixfmt
    cmake
    gnumake
    gcc
    ripgrep
    fd
    nodejs
  ];

  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;
  };
}
