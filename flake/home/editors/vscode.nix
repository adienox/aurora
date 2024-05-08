{ pkgs, ... }: {
  home.packages = with pkgs; [ nixpkgs-fmt ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}
