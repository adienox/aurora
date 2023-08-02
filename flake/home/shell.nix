{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    neofetch
    trash-cli
    tldr
    zoxide
    unzip
    bat
    exa
  ];
  programs.starship.enable = true;
}
