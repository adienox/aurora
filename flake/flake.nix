{
  description = "Anomaly";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland }:
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
                extraSpecialArgs = { inherit hyprland; };
              };
            }
          ];
        };
      };
    };
}
