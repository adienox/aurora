{ config, inputs, ... }:
let colors = config.colorScheme.colors;
in {
  imports = [ inputs.schizofox.homeManagerModule ];

  programs.schizofox = {
    enable = true;

    theme = {
      background-darker = colors.base01;
      background = colors.base00;
      foreground = colors.base05;
      darkreader.enable = true;
    };

    search = {
      defaultSearchEngine = "Brave";
      removeEngines =
        [ "DuckDuckGo" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia (en)" ];
      searxUrl = "https://searx.be";
      searxQuery = "https://searx.be/search?q={searchTerms}&categories=general";
      addEngines = [
        {
          Name = "Brave";
          Description = "brave's search engine";
          Alias = "";
          Method = "GET";
          URLTemplate = "https://search.brave.com/search?q={searchTerms}";
        }
        {
          Name = "AniWave";
          Description = "anime search";
          Alias = "aa";
          Method = "GET";
          URLTemplate = "https://aniwave.to/filter?keyword={searchTerms}";
        }
        {
          Name = "YouTube";
          Description = "pretty self explainatory";
          Alias = "yt";
          Method = "GET";
          URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
        }
        {
          Name = "Nix Packages";
          Description = "come'on nix without nix package search?";
          Alias = "np";
          Method = "GET";
          URLTemplate =
            "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
        }
      ];
    };

    security = {
      sanitizeOnShutdown = false;
      sandbox = true;
      userAgent =
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    };

    misc = {
      drmFix = true;
      disableWebgl = false;
    };

    extensions.extraExtensions = {
      "webextension@metamask.io".install_url =
        "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
    };
  };
}
