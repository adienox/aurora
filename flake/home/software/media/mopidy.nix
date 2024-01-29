{ pkgs, ... }: {
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mpoidy-mpd
      mopidy-mpris
      mopidy-notify
      mopidy-mopify
    ];
    settings = {
      file = {
        media_dirs = [ "$XDG_MUSIC_DIR|Music" ];
        follow_symlinks = true;
        excluded_file_extensions = [ ".html" ".zip" ".jpg" ".jpeg" ".png" ];
      };
    };
  };

}
