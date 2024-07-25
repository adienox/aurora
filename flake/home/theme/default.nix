{
  config,
  lib,
  ...
}: {
  imports = [
    ./gtk.nix
    ./qt.nix
    {_module.args = {default = import ./settings.nix {inherit config lib;};};}
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "peach";
    enable = true;
  };
}
