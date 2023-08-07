{ pkgs, ... }: {
  home.packages = [ pkgs.gtklock ];

  xdg.configFile = {
    "gtklock/style.css".source = ./style.css;
    "gtklock/background.jpg".source = ./background.jpg;
  };
}
