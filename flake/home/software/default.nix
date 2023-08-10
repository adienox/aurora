{ config, pkgs, ... }: {
  imports = [
    ./dunst.nix
    ./discord.nix
    ./media.nix
    ./git.nix
    ./librewolf.nix
  ];
}
