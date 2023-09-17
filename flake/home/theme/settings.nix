{ config, lib, ... }:
let colorlib = import ./libs.nix lib;
in rec {
  browser = "librewolf";
  editor = "nvim";

  colors = config.colorScheme.colors;
  xcolors = lib.mapAttrs (name: color: colorlib.x color) colors;

  # NOTE: I have no idea how this works
  # it correctly passes opacity to colorlib.rgba but I don't know how
  rgba = lib.mapAttrs (_: colorlib.rgba) colors;

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
