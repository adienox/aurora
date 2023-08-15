{ config, pkgs, ... }: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    font = {
      name = "Readex Pro";
      size = 11;
    };
    iconTheme = {
      name = "win11-dark";
      package = pkgs.win11-icon-theme;
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
}
