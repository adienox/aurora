{
  config,
  pkgs,
  default,
  ...
}:
{
  gtk = {
    enable = true;

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    font = {
      name = default.settings.font.default;
      size = default.settings.font.size;
    };

    iconTheme = {
      name = "win11-dark";
      package = pkgs.win11-icon-theme;
    };

    catppuccin = {
      enable = false;
      accent = "peach";
      tweaks = [
        "black"
        "rimless"
      ];
      flavor = "mocha";
    };

    theme = {
      name = "Catppuccin-GTK-Orange-Dark";
      package = pkgs.magnetic-catppuccin-gtk.override {
        shade = "dark";
        accent = [ "orange" ];
        tweaks = [
          "black"
        ];
      };
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
