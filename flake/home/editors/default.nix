{ pkgs, ... }: {
  imports = [
    # ./emacs.nix
    # ./vscode.nix
    ./nvchad.nix
  ];

  # useful packages
  home.packages = with pkgs; [ python311Packages.howdoi ];
}
