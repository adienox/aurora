{pkgs, ...}: {
  imports = [./config.nix];

  home.packages = with pkgs; [
    noto-fonts-cjk-sans # Fonts
  ];

  programs.waybar = {
    enable = true;
    catppuccin.enable = false;
    style = ./style.css;
  };
}
