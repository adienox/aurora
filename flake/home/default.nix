{ lib, ... }:
{
  imports = [
    ./desktop
    ./editors
    ./shell
    ./software
    ./theme
    ./secrets.nix
  ];

  home.username = "nox";
  home.homeDirectory = "/home/nox";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  #FIXME: Remove this once its fixed
  nixpkgs.config.permittedInsecurePackages = [
    "python3.12-youtube-dl-2021.12.17"
    "electron-27.3.11"
  ];
}
