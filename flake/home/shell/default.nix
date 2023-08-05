{ config, pkgs, ... }: {
  imports = [
    ./zoxide.nix
    ./zsh.nix
    ./starship.nix
    ./xdg.nix
    ./cli.nix
  ];
}