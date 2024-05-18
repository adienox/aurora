{ pkgs, ... }: {
  imports = [
    # ./emacs.nix
    # ./vscode.nix
    ./nvim.nix
  ];
}
