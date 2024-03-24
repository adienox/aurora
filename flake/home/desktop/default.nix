{ pkgs, ... }: {
  imports = [
    ./hyprland
    ./waybar
    ./wlogout
    ./rofi
    # ./swaync
    ./mako.nix
    ./ags.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./services.nix
    ./shell-scripts.nix
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  # Apple Emoji
  xdg.dataFile = {
    "fonts/Emoji/AppleColorEmoji.ttf" = {
      source = pkgs.fetchurl {
        url =
          "https://github.com/samuelngs/apple-emoji-linux/releases/download/v16.4/AppleColorEmoji.ttf";
        hash = "sha256-goY9lWBtOnOUotitjVfe96zdmjYTPT6PVOnZ0MEWh0U=";
      };
      onChange = "${pkgs.fontconfig}/bin/fc-cache -f";
    };
  };

  xdg.configFile."io.github.zefr0x.ianny/config.toml".source =
    (pkgs.formats.toml { }).generate "config.toml" {
      timer = {
        idle_timeout = 240;
        short_break_timeout = 300;
        long_break_timeout = 1000;
        short_break_duration = 10;
        long_break_duration = 60;
      };
      notification = {
        show_progress_bar = true;
        minimum_update_delay = 1;
      };
    };

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
