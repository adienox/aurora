{ lib, ... }:
let
  colorlib = import ./libs.nix lib;
in rec {
  browser = "librewolf";
  editor = "nvim";

  colors = import ./colors.nix;
  xcolors = lib.mapAttrs (name: color: colorlib.x color) colors;
  rgba = lib.mapAttrs (_: colorlib.rgba) colors;

  settings = { timeout = 330; };

  files = {
    flake = "$HOME/aurora/flake";
    keepass = "/home/nox/Documents/vault/armoury.kdbx";
  };

  font = {
    default = "Readex Pro";
    monospace = "CaskaydiaCove NF";
    size = 16;
  };

  terminal = {
    font = "CaskaydiaCove NF";
    name = "wezterm";
    opacity = 1.0;
    size = 9;
  };
}
