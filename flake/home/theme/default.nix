{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./gtk.nix
    ./qt.nix
    {_module.args = {default = import ./settings.nix {inherit config pkgs lib;};};}
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "peach";
    enable = true;
  };
}
