{ config, pkgs, ... }:
let
  user = "adienox";
  username = "nox";
in {
  imports = [
    ./desktop.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./power-management.nix
    ./security.nix
    ./software.nix
  ];

  boot = {
    kernelModules = [ "amdgpu" ];
    kernelParams = [ "module_blacklist=nvidia" ];
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        useOSProber = false;
        efiSupport = true;
        configurationLimit = 5;
      };
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = user;
    shell = pkgs.zsh;
    extraGroups =
      [ "networkmanager" "wheel" "video" "audio" "adbusers" "input" ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };
  };

  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      dates = "04:00";
      flake = "${config.users.users.nox.home}/aurora/flake";
      flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    };
  };
}
