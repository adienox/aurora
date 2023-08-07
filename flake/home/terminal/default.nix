{ config, pkgs, ... }: {
  imports = [
    ./neofetch.nix
    ./cava.nix
    ./kitty.nix
    ./btop.nix
  ];
}
