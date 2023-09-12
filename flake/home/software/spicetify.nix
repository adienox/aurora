{ pkgs, lib, inputs, ... }:
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
      sha256 = "sha256-fnUINAgBCaklVDR2JsyvnN0ekBJ/sOnUNnKStug2txs=";
    };
    spicetify-stats = pkgs.fetchgit {
      url = "https://github.com/harbassan/spicetify-stats";
      sha256 = "sha256-YyAAaHgHebKrqeoXJMQUs0QQ05bHXPrKeEqlsg6pugU=";
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
      accent = "f38ba8";
      accent-active = "f38ba8";
      accent-inactive = "000000";
      banner = "f38ba8";
      border-active = "f38ba8";
      border-inactive = "313244";
      header = "585b70";
      highlight = "585b70";
      main = "000000";
      notification = "89b4fa";
      notification-error = "f38ba8";
      subtext = "a6adc8";
      text = "cdd6f4";
    };

    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
      new-releases
      marketplace
      {
        name = "stats";
        src = spicetify-stats;
        appendName = false;
      }
    ];

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplayMod
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
