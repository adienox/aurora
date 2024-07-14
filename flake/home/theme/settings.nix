{
  config,
  lib,
  ...
}: let
  colorlib = import ./libs.nix lib;
in rec {
  browser = "firefox";
  editor = "nvim";
  catppuccin = {
    flavor = "mocha";
    accent = "peach";
    enable = true;
  };

  firefox = {
    profile = "nox";
    userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";

    features = {
      account = true;
      webglDisabled = true;
      screenshotsDisabled = false;
      letterboxing = false;
    };

    newtab = {
      includeDownloads = false;
      includeVisited = false;
      topSites = true;
    };

    dns = {
      mode = 2;
      uri = "https://dns.quad9.net/dns-query";
      # 0 = default
      # 1 = browser picks faster
      # 2 = DoH with system dns fallback
      # 3 = DoH without fallback
      # 5 = DoH is off
    };
  };

  settings = {
    timeout = 330;
    floating_opacity = "0.7";
    opacity = "0.8";
    font = {
      default = "Readex Pro";
      monospace = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };

  files = {
    flake = "${config.home.homeDirectory}/aurora/flake";
    keepass = "${config.home.homeDirectory}/Documents/vault/armoury.kdbx";
  };

  terminal = {
    font = "JetBrainsMono Nerd Font";
    name = "kitty";
    opacity = 0.7;
    size = 13;
  };

  colors = import ./colors.nix;
  xcolors = lib.mapAttrs (name: color: colorlib.x color) colors;
  rgba = lib.mapAttrs (_: colorlib.rgba) colors;
}
