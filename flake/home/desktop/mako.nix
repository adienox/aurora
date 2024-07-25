{
  default,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [libnotify];

  services.mako = {
    enable = true;
    catppuccin.enable = false;
    font = default.settings.font.default;
    sort = "+time";
    margin = "10,10,0";
    padding = "10";
    borderSize = 2;
    borderRadius = 6;
    defaultTimeout = 10000;
    groupBy = "body";
    # iconPath = "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark";

    backgroundColor = default.xcolors.background;
    textColor = default.xcolors.foreground;
    borderColor = default.xcolors.accent;
    progressColor = default.xcolors.base03;
    # progressColor = "#363a4f";
  };
}
