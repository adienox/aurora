{ pkgs, lib, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify =
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin-mocha;
      colorScheme = "red";
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
      enabledCustomApps = with spicePkgs.apps; [ lyrics-plus new-releases reddit ];

      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        shuffle
        adblock
        playlistIcons
        lastfm
        genre
        historyShortcut
        bookmark
        fullAlbumDate
        groupSession
        popupLyrics
      ];
    };
}
