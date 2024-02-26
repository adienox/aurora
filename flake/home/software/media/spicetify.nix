{ pkgs, default, lib, inputs, ... }:
let spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" ];

  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify = let
    # use a different version of spicetify-themes than the one provided by
    # spicetify-nix
    officialThemes = pkgs.fetchgit {
      url = "https://github.com/spicetify/spicetify-themes";
      sha256 = "sha256-iMRutzOrZHaKfHOr2qOM/TkTYHysFBlmunVhU65kf2k=";
    };
  in {
    enable = true;
    theme = {
      name = "text";
      src = officialThemes;
      appendName = true; # theme is located at "${src}/text" not just "${src}"

      # changes to make to config-xpui.ini for this theme:
      patches = {
        "xpui.js_find_8008" = ",(\\w+=)56,";
        "xpui.js_repl_8008" = ",\${1}32,";
      };
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };

    colorScheme = "custom";
    customColorScheme = {
      accent = default.colors.accent;
      accent-active = default.colors.base08;
      accent-inactive = default.colors.base00;
      banner = default.colors.base08;
      border-active = default.colors.base08;
      border-inactive = default.colors.base02;
      header = default.colors.base04;
      highlight = default.colors.base04;
      main = default.colors.base00;
      notification = default.colors.base01;
      notification-error = default.colors.base08;
      subtext = default.colors.extra04;
      text = default.colors.base07;
    };

    enabledCustomApps = with spicePkgs.apps; [ marketplace ];

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      hidePodcasts
      shuffle
      adblock
      lastfm
      genre
      historyShortcut
      fullAlbumDate
      groupSession
      popupLyrics
    ];
  };
}
