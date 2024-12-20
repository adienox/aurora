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

    sesh-202.url = "github:nixos/nixpkgs/51b45dc262830ab95c7b9b039bb4f911d4b2509b";
    pavucontrol-6.url = "github:nixos/nixpkgs/d4f247e89f6e10120f911e2e2d2254a050d0f732";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";

    pyprland.url = "github:hyprland-community/pyprland";

    yazi.url = "github:sxyazi/yazi";
    catppuccin.url = "github:catppuccin/nix";

    sops-nix.url = "github:Mic92/sops-nix";

    xremap-flake.url = "github:xremap/nix-flake";
    anipy-cli.url = "github:sdaqo/anipy-cli";

    zen-browser.url = "github:MarceColl/zen-browser-flake";

    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.yazi.overlays.default
          (import ./system/pkgs)
        ];
      };
    in
    {
      nixosConfigurations = {
        anomaly = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system inputs;
          };
          modules = [
            ./system
            inputs.sops-nix.nixosModules.sops
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
            inputs.sops-nix.homeManagerModules.sops
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
