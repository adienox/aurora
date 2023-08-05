{ config, pkgs, ... }: {
  imports = [
    ./dunst.nix
    ./discord.nix
    ./spicetify.nix
  ];
}
