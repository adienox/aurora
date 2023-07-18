{ config, pkgs, ... }: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    font = {
      name = "Readex Pro";
      size = 11;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Red-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "red" ];
        tweaks = [ "black" "rimless" ];
        variant = "mocha";
      };
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=true;
    };
  };
  qt = {
    enable = true;
    platformTheme = "qtct";
  };
}
