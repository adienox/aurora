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
}
