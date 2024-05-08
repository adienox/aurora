{ pkgs, ... }: {
  imports = [
    # ./emacs.nix
    ./vscode.nix
    ./nvchad.nix
  ];
}
