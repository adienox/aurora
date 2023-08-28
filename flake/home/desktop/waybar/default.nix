{ pkgs, ... }: {
  imports = [ ./config.nix ];

  home.packages = with pkgs;
    [
      noto-fonts-cjk-sans # Fonts
    ];

  programs.waybar = {
    enable = true;
    style = ./style.css;
  };
}
