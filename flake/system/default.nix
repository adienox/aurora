{
  config,
  pkgs,
  ...
}: let
  user = "adienox";
  username = "nox";
in {
  imports = [
    ./desktop.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./security.nix
    ./software.nix
    ./nvidia.nix
    ./amd.nix
    ./power-management.nix
  ];

  boot = {
    kernelModules = ["amdgpu"];
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;
      systemd-boot.enable = true;
    };
    plymouth = {enable = true;};
  };

  users.users.${username} = {
    isNormalUser = true;
    description = user;
    shell = pkgs.zsh;
    extraGroups = [
      "vboxusers"
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "adbusers"
      "input"
      "docker"
      "wireshark"
    ];
  };

  nixpkgs.config.allowUnfree = true;
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
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };
  };

  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      dates = "09:00";
      flake = "${config.users.users.nox.home}/aurora/flake";
      flags = ["--update-input" "nixpkgs" "-L"];
    };
  };
}
