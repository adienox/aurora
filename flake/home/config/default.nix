{ config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./theme.nix
  ];
}
