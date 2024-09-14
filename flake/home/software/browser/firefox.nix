{
  pkgs,
  inputs,
  default,
  ...
}: let
  youtube-icon = pkgs.fetchurl {
    url = "https://www.youtube.com/s/desktop/dbf5c200/img/favicon_144x144.png";
    hash = "sha256-lQ5gbLyoWCH7cgoYcy+WlFDjHGbxwB8Xz0G7AZnr9vI=";
  };
  aniwave-icon = pkgs.fetchurl {
    url = "https://s2.bunnycdn.ru/assets/sites/aniwave/favicon1.png";
    hash = "sha256-MK40CLcyq7CoGbV/38MUz7JEcfVHYEHdBwhDHvuQ9oc=";
  };
  brave-icon = pkgs.fetchurl {
    url = "https://brave.com/static-assets/images/brave-logo-sans-text.svg";
    hash = "sha256-JTD4D98hRLYvlpU6gcaYjJwxpsx8necuBpB5SFgXy+c=";
  };
in {
  programs.firefox = {
    enable = true;

    profiles.${default.firefox.profile} = {
      search = {
        default = "Brave";
        force = true;
      };

      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["np"];
        };

        "Youtube" = {
          urls = [
            {
              template = "https://www.youtube.com/results";
              params = [
                {
                  name = "search_query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = youtube-icon;
          definedAliases = ["yt"];
        };

        "Brave" = {
          urls = [
            {
              template = "https://search.brave.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
                {
                  name = "summary";
                  value = "1";
                }
              ];
            }
          ];

          icon = brave-icon;
          definedAliases = ["bb"];
        };

        "AniWave" = {
          urls = [
            {
              template = "https://aniwave.to/filter";
              params = [
                {
                  name = "keyword";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = aniwave-icon;
          definedAliases = ["aa"];
        };

        "Bing".metaData.hidden = true;
        "DuckDuckGo".metaData.hidden = true;
        "Amazon.com".metaData.hidden = true;
        "Wikipedia (en)".metaData.alias = "wk";
        "Google".metaData.alias = "gg";
      };

      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        sponsorblock
        ublock-origin
        darkreader
        facebook-container
        leechblock-ng
        search-by-image
        simple-tab-groups
        stylus
        clearurls
        don-t-fuck-with-paste
        vimium
        canvasblocker
        redirector
        skip-redirect
        bitwarden
        # web-archives
        # wikiwand-wikipedia-modernized
        # youtube-shorts-block
        # dearrow
        # youtube-recommended-videos
        # enhancer-for-youtube
        # smart-referer
        # temporary-containers
        # tabcenter-reborn
        # multi-account-containers
        # fingerprint spoofing
        # readwise
        # imagur
        # load progress bar
      ];

      settings = import ./settings.nix {inherit default;};
    };
  };
}
