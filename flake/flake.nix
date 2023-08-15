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

    ags.url = "github:Aylur/ags";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-index-db, ... }@inputs:
    {
      nixosConfigurations = {
        anomaly = nixpkgs.lib.nixosSystem {
          system = "X86_64-linux";
          modules = [
            ./system
            nix-index-db.nixosModules.nix-index
            # optional to also wrap and install comma
            { programs.nix-index-database.comma.enable = true; }
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
