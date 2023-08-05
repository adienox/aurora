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
      inputs.nixpkgs.follows = "nixpkgs"; # override this repo's nixpkgs snapshot
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    {
      imports = [ ./pkgs ];
      nixosConfigurations = {
        anomaly = nixpkgs.lib.nixosSystem {
          system = "X86_64-linux";
          modules = [
            ./system
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
