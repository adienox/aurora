{ config, lib, ... }: {
  imports = [
    ./gtk.nix
    ./qt.nix
    { _module.args = { default = import ./settings.nix { inherit config lib; }; }; }
  ];
}
