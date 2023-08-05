{config, pkgs, ...}: {
  imports = [
    ./emacs.nix
    ./vscode.nix
  ];
}