{
  description = "Use with care.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = { url = "github:dj95/zjstatus"; };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";

    hyprlock.url = "github:hyprwm/hyprlock";

    hypridle.url = "github:hyprwm/hypridle";

    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import ./system/pkgs) ];
      };
    in {
      nixosConfigurations = {
        anomaly = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system inputs; };
          modules = [ ./system inputs.nh.nixosModules.default ];
        };
      };

      homeConfigurations = {
        nox = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home
            inputs.nix-index-db.hmModules.nix-index
            inputs.hyprlock.homeManagerModules.hyprlock
            inputs.hypridle.homeManagerModules.hypridle
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
