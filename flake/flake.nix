{
  description = "Use with care.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

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

    ags.url = "github:Aylur/ags";
    
    xremap-flake.url = "github:xremap/nix-flake";
    
    nix-colors.url = "github:misterio77/nix-colors";

    schizofox.url = "github:schizofox/schizofox";

  };

  outputs = { self, nixpkgs, home-manager, nix-index-db, ... }@inputs: {
    nixosConfigurations = {
      anomaly = nixpkgs.lib.nixosSystem {
        system = "X86_64-linux";
        modules = [
          ./system
          # nix db config
          nix-index-db.nixosModules.nix-index
          {
            programs.nix-index-database.comma.enable = true;
          }

          # home manager config
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.nox = { imports = [ ./home ]; };
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
    };
  };
}
