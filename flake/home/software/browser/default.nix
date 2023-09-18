{ pkgs, ... }: {
  imports = [
    ./librewolf.nix
    ./firefox.nix
    # ./schizofox.nix
  ];

  home.packages = with pkgs; [ brave ];
}
