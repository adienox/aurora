{
  config,
  pkgs,
  ...
}: let
  browser = ["firefox.desktop"];
  image-viewer = ["imv.desktop"];
  video-player = ["mpv.desktop"];
  document-viewer = ["org.pwmt.zathura.desktop"];

  associations = {
    "text/html" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "application/json" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];

    "application/pdf" = document-viewer;
    "application/epub+zip" = document-viewer;
    "application/x-mobipocket-ebook" = document-viewer;

    "audio/*" = video-player;
    "video/*" = video-player;
    "image/*" = image-viewer;
    "image/png" = image-viewer;
    "image/jpg" = image-viewer;
    "image/gif" = image-viewer;
    "x-scheme-handler/discord" = ["discord.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
  };
in {
  home.packages = [pkgs.xdg-utils];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      videos = "$HOME/Videos";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      desktop = null;
      publicShare = null;
      templates = null;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
  };
}
