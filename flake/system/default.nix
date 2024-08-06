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
    package = pkgs.nixFlakes;
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      extra-substituters = ["https://yazi.cachix.org"];
      extra-trusted-public-keys = ["yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="];
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
