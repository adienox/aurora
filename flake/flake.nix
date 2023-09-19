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

    hyprland.url = "github:hyprwm/Hyprland";

    xremap-flake.url = "github:xremap/nix-flake";

    schizofox.url = "github:schizofox/schizofox";
  };

  outputs = { nixpkgs, home-manager, nix-index-db, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (pkg: true);
        overlays = [ (import ./system/pkgs) ];
      };
    in {
      nixosConfigurations = {
        anomaly = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system; };

          modules = [
            # system config
            ./system

            # nix db config
            nix-index-db.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
          ];
        };
      };

      homeConfigurations = {
        nox = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
