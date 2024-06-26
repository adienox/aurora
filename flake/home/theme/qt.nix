{ pkgs, ... }:
# Qt theming with Kvantum
{
  qt = {
    enable = true;
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "Peach";
      variant = "Mocha";
    })
  ];

  home.sessionVariables = { QT_STYLE_OVERRIDE = "kvantum"; };

  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Peach";
    };
}
