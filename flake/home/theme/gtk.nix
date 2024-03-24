{ config, pkgs, default, ... }: {
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

    theme = {
      name = "Catppuccin-Mocha-Standard-Red-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "peach" ];
        tweaks = [ "black" "rimless" ];
        variant = "mocha";
      };
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
