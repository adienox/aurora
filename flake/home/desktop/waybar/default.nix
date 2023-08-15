{ config, pkgs, inputs, ... }:
let
  waybar_config = import ./config.nix;
  waybar_style = import ./style.nix;
in
{
  imports = [ ./config.nix ];

  home.packages = with pkgs; [
    noto-fonts-cjk-sans # Fonts
  ];

  programs.waybar = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
    style = ./style.css;
  };
}
