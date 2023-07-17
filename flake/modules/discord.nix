{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      discord = prev.discord.override {
        withOpenASAR = true;
        withVencord = true;
      };
    })
  ];

  home.packages = with pkgs; [ discord ];
}
