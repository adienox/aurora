{ pkgs, ... }: {
  programs = {
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];

      bindings = {
        l = "seek 5";
        h = "seek -5";
        k = "add volume 5";
        j = "add volume -5";
        s = "screenshot";
        WHEEL_UP = "add volume 5";
        WHEEL_DOWN = "add volume -5";
      };

      config = {
        screenshot-template = "~/Pictures/mpvscreenshots/%F (%P) %n";
        ytdl-format = "bestvideo[height<=1080]+bestaudio/best[height<=1080]";
        save-position-on-quit = true;
        write-filename-in-watch-later-config = true;
        ignore-path-in-watch-later-config = true;
        cache = "yes";
        demuxer-max-bytes = "800M";
        demuxer-max-back-bytes = "200M";
        volume = 100;
        msg-color = true;
        keep-open = true;
        cursor-autohide-fs-only = true;
        cursor-autohide = 1000;
        osc = "no";
        osd-bar = "no";
        script-opts = "ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp";
        border = "no";
      };
    };
  };

  xdg.configFile = {
    "mpv/scripts/mpris.so".source =
      "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";

    "mpv/scripts/sponsorblock.lua".source =
      "${pkgs.mpvScripts.sponsorblock}/share/mpv/scripts/sponsorblock.lua";

    "mpv/scripts/thumbfast.lua".source =
      "${pkgs.mpvScripts.thumbfast}/share/mpv/scripts/thumbfast.lua";

    "mpv/scripts/uosc".source =
      "${pkgs.mpvScripts.uosc}/share/mpv/scripts/uosc";

    "mpv/scripts/user-input.lua".source = pkgs.fetchurl {
      url =
        "https://raw.githubusercontent.com/CogentRedTester/mpv-user-input/40a9fa59d37d7532c055e5c831c1f2b61c6ee741/user-input.lua";
      hash = "sha256-a0Wfu+qibYQ+AVEqdsOD+wa0DWtb3/HMTdPF2gTeKNA=";
    };

    "mpv/script-modules/user-input-module.lua".source = pkgs.fetchurl {
      url =
        "https://raw.githubusercontent.com/CogentRedTester/mpv-user-input/40a9fa59d37d7532c055e5c831c1f2b61c6ee741/user-input-module.lua";
      hash = "sha256-qUIA73xU0KWdDAnY69ArwMc80SL5D0qKym7fZK/L+2Y=";
    };

    "mpv/script-modules/md5.lua".source = pkgs.fetchurl {
      url =
        "https://raw.githubusercontent.com/kikito/md5.lua/4b5ce0cc277a5972aa3f5161d950f809c2c62bab/md5.lua";
      hash = "sha256-ZLkMRdfvNkNW+l82VcN+Ws08zXioCNWKlg768zt0lls=";
    };
  };
}
