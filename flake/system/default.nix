{ config, lib, pkgs, ... }:
let
  user = "adienox";
  username = "nox";
in
{
  imports = [
    ./desktop.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./power-management.nix
    ./software.nix
    ];

  boot = {
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
    packages = with pkgs; [ ];
  };

  security = {
    polkit.enable = true;
    pam.services.gtklock = {
      text = ''
        auth include login
      '';
    };
    sudo.extraConfig = ''
      Defaults env_reset,pwfeedback
    '';
    pam.services.${username}.enableGnomeKeyring = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };
}