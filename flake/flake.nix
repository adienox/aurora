{
  description = "Use with care.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    discord-43.url = "github:nixos/nixpkgs/a343533bccc62400e8a9560423486a3b6c11a23b";

    rofi-1751.url = "github:nixos/nixpkgs/58ae79ea707579c40102ddf62d84b902a987c58b";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland?ref=v0.41.2";
      submodules = true;
    };

    yazi.url = "github:sxyazi/yazi";
    catppuccin.url = "github:catppuccin/nix";

    xremap-flake.url = "github:xremap/nix-flake";
    anipy-cli.url = "github:sdaqo/anipy-cli";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        inputs.yazi.overlays.default
        (import ./system/pkgs)
      ];
    };
  in {
    nixosConfigurations = {
      anomaly = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs;};
        modules = [
          ./system
        ];
      };
    };

    homeConfigurations = {
      nox = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home
          inputs.nix-index-db.hmModules.nix-index
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = {inherit inputs;};
      };
    };
  };
}
