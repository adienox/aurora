{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.nox = {

      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }];
          icon =
            "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "np" ];
        };
      };
      search.force = true;

      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        sponsorblock
        ublock-origin
        darkreader
        youtube-shorts-block
      ];

      settings = {
        "browser.download.useDownloadDir" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.tabs.firefox-view" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";
        "xpinstall.signatures.required" = false;
        
        # Release notes and vendor URLs
        "app.releaseNotesURL" = "http://127.0.0.1/";
        "app.vendorURL" = "http://127.0.0.1/";
        "app.privacyURL" = "http://127.0.0.1/";

        # Disable plugin installer
        "plugins.hide_infobar_for_missing_plugin" = true;
        "plugins.hide_infobar_for_outdated_plugin" = true;
        "plugins.notifyMissingFlash" = false;

        # Speeding it up
        "network.http.pipelining" = true;
        "network.http.proxy.pipelining" = true;
        "network.http.pipelining.maxrequests" = 10;
        "nglayout.initialpaint.delay" = 0;

        # Isolate cookies, you don't have to delete them every time, duh
        "privacy.firstparty.isolate" = true;

        # Extensions cannot be updated without permission
        "extensions.update.enabled" = false;

        # Use LANG environment variable to choose locale
        "intl.locale.matchOS" = true;
        
          # Allow unsigned langpacks
  "extensions.langpacks.signatures.required" = false;

  # Disable default browser checking.
  "browser.shell.checkDefaultBrowser" = false;

  # Prevent EULA dialog to popup on first run
  "browser.EULA.override" = true;

  # Don't disable extensions dropped in to a system
  # location, or those owned by the application
  "extensions.autoDisableScopes" = 3;

  # Don't call home for blacklisting
  "extensions.blocklist.enabled" = false;

  # Disable homecalling
  "app.update.url" = "http://127.0.0.1/";
  "startup.homepage_welcome_url" = "";
  "browser.startup.homepage_override.mstone" = "ignore";

  # Help url
  "app.support.baseURL" = "http://127.0.0.1/";
  "app.support.inputURL" = "http://127.0.0.1/";
  "app.feedback.baseURL" = "http://127.0.0.1/";
  "browser.uitour.url" = "http://127.0.0.1/";
  "browser.uitour.themeOrigin" = "http://127.0.0.1/";
  "plugins.update.url" = "http://127.0.0.1/";
  "browser.customizemode.tip0.learnMoreUrl" = "http://127.0.0.1/";
      };
    };
  };
}
