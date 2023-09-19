{ lib, ... }:
let
  colorlib = import ./libs.nix lib;
in rec {
  browser = "librewolf";
  editor = "nvim";

  firefox = {
    account = true;
    webglDisabled = true;
    userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    profile = "nox";
    screenshotsDisabled = false;
    newtab = {
      includeDownloads = false;
      includeVisited = false;
      topSites = true;
    };
  };

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
  
  colors = import ./colors.nix;
  xcolors = lib.mapAttrs (name: color: colorlib.x color) colors;
  rgba = lib.mapAttrs (_: colorlib.rgba) colors;
}
