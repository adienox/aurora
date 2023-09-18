{ pkgs, ... }: {
  imports = [
    ./hyprland
    ./waybar
    ./gtklock
    ./wlogout
    ./rofi
    ./swaync
    ./swayidle.nix
    ./swww.nix
    # ./espanso.nix
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  # Apple Emoji
  # FIX: make a package for this
  xdg.dataFile = {
    "fonts/Emoji/AppleColorEmoji.ttf" = {
      source = pkgs.fetchurl {
        url =
          "https://github.com/samuelngs/apple-emoji-linux/releases/download/v16.4/AppleColorEmoji.ttf";
        hash = "sha256-goY9lWBtOnOUotitjVfe96zdmjYTPT6PVOnZ0MEWh0U=";
      };
      onChange = "fc-cache -f";
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
