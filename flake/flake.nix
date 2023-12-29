{
  description = "Use with care.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-31.url =
      "github:nixos/nixpkgs/90e85bc7c1a6fc0760a94ace129d3a1c61c3d035";

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
  };

  outputs = { nixpkgs, home-manager, nix-index-db, ... }@inputs:
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
          modules = [ ./system ];
        };
      };

      homeConfigurations = {
        nox = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home nix-index-db.hmModules.nix-index ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
