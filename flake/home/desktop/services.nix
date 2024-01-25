{ config, pkgs, ... }: {
  home.packages = with pkgs; [ swww swayosd valent brightnessctl ];

  systemd.user.services = {
    swww = {
      Unit = {
        Description = "Wayland wallpaper daemon";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        ExecStartPost =
          "${pkgs.swww}/bin/swww img ${config.xdg.cacheHome}/background";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    swayosd = {
      Unit = {
        Description = "Volume/backlight OSD indicator";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    valent = {
      Unit = {
        Description = "GTK KdeConnect";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.valent}/bin/valent --gapplication-service";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    wlsunset = {
      Unit = {
        Description = "NightTemp";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.wlsunset}/bin/wlsunset -t 5000 -S 8:00 -s 19:00";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
