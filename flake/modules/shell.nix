{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    pfetch
    trash-cli
    tldr
    zoxide
    unzip
    bat
    exa
    tmux
  ];

  programs.starship.enable = true;
}
