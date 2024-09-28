{
  pkgs,
  inputs,
  ...
}: {
  imports = [./firefox.nix];

  home.packages = with pkgs; [inputs.zen-browser.packages.${pkgs.system}.default];
}
