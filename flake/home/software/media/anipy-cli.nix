{ config, pkgs, ... }: {
  home.packages = with pkgs; [ anipy-cli ];

  xdg.configFile."anipy-cli/config.yaml".source =
    (pkgs.formats.yaml { }).generate "config.yaml" {
      anime_types = [ "sub" "dub" ];
      auto_map_mal_to_gogo = false;
      auto_open_dl_defaultcli = false;
      auto_sync_mal_to_seasonals = false;
      dc_presence = false;
      ffmpeg_hls = false;
      mal_password = "";
      mal_status_categories = [ "watching" ];
      mal_user = "";
      mpv_commandline_options = [ "--keep-open=no" ];
      player_path = "mpv";
      reuse_mpv_window = false;
      vlc_commandline_options = [ ];
      download_folder_path =
        "${config.xdg.userDirs.download}/anilist/seasonals";
      download_name_format = "{show_name}_{episode_number}.mp4";
      download_remove_dub_from_folder_name = false;
      ffmpeg_log_path =
        "${config.xdg.cacheHome}/anipy_cli/user_files/ffmpeg_log";
      gogoanime_url = "https://gogoanime.gg/";
      history_file_path =
        "${config.xdg.cacheHome}/anipy_cli/user_files/history.json";
      mal_local_user_list_path =
        "${config.xdg.cacheHome}/anipy_cli/user_files/mal_list.json";
      seasonal_file_path =
        "${config.xdg.cacheHome}/anipy_cli/user_files/seasonals.json";
      seasonals_dl_path = "${config.xdg.userDirs.download}/anilist/seasonals";
      user_files_path = "${config.xdg.cacheHome}/anipy_cli/user_files";
    };
}
