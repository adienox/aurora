{ pkgs, ... }: {
  systemd.user.services.swww = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww init";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}