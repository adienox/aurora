{ pkgs, ... }:
{
  imports = [ ./rnnoise.nix ./spicetify.nix ./newsboat.nix ];

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer

    # images
    imv
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];

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
        ytdl-format = "bestvideo+bestaudio";
        save-position-on-quit = true;
        cache = "yes";
        demuxer-max-bytes = "800M";
        demuxer-max-back-bytes = "200M";
        volume = 100;
        msg-color = true;
        keep-open = true;
        cursor-autohide-fs-only = true;
        cursor-autohide = 1000;
      };
    };
  };

  services = { playerctld.enable = true; };
}
