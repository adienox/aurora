{ config, ... }: {
  programs.hyprlock = {
    enable = true;
    backgrounds =
      [{ path = "${config.xdg.userDirs.pictures}/backgrounds/car.png"; }];
  };
}
