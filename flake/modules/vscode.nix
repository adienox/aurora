{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      ms-python.python
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };
}
