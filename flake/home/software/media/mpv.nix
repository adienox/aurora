{ pkgs, ... }: {
  programs = {
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = with pkgs.mpvScripts; [
        mpris
        sponsorblock
        thumbfast
        webtorrent-mpv-hook
        uosc
      ];

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
      };
    };
  };
}
