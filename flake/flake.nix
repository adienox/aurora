{
  description = "Anomaly";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur }:
    let
      system = "X86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        anomaly = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            nur.nixosModules.nur
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nox = { imports = [ ./home.nix ]; };
            }
          ];
        };
      };
    };
}
