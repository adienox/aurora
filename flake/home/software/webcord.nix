{ pkgs, lib, inputs, ... }:
with lib;
let
  catppuccin-mocha = pkgs.fetchFromGitHub {
    owner = "adienox";
    repo = "catppuccin-discord";
    rev = "e2d2fe70c3447d6ff644a6a184afcb44894179fa";
    hash = "sha256-+79fVFkq5VtxDUMqaC8+T7r9WuK1/WnNJgBDbKoUp4Y=";
  };
in
{
  home.packages = with pkgs; [
    webcord-vencord # webcord with vencord extension installed
  ];

  xdg.configFile = {
    "WebCord/Themes/mocha" = {
      source = "${catppuccin-mocha}/theme.css";
    };
  };
}
