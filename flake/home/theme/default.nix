{ config, lib, ... }: {
  imports = [
    ./gtk.nix
    ./qt.nix
    ./colors.nix
    { _module.args = { default = import ./settings.nix { inherit config lib; }; }; }
  ];
}
