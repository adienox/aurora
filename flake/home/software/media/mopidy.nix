{ config, pkgs, ... }: {

  # services.mopidy = {
  #   enable = true;
  #   extensionPackages = with pkgs; [
  #     mopidy-mpd
  #     mopidy-mpris
  #     mopidy-notify
  #     mopidy-youtube
  #   ];
  #   settings = {
  #     file = {
  #       media_dirs = [ "${config.home.homeDirectory}/Music" ];
  #       follow_symlinks = true;
  #       excluded_file_extensions = [ ".html" ".zip" ".jpg" ".jpeg" ".png" ];
  #     };
  #     mpd = { hostname = "::"; };
  #     notify = { enable = true; };
  #   };
  # };

  services = {
    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      extraConfig = ''
        audio_output {
          type            "pipewire"
          name            "PipeWire Sound Server"
        }
        auto_update "yes"
        restore_paused "yes"
      '';
    };
    mpd-mpris.enable = true;
  };

  programs.ncmpcpp = {
    enable = true;
    bindings = [
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "J";
        command = [ "select_item" "scroll_down" ];
      }
      {
        key = "K";
        command = [ "select_item" "scroll_up" ];
      }
    ];
  };

}
