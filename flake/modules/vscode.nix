{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      pkief.material-product-icons
      pkief.material-icon-theme
      vscodevim.vim
      kahole.magit
      oderwat.indent-rainbow
      esbenp.prettier-vscode
      jnoortheen.nix-ide
      yzhang.markdown-all-in-one
    ];
  };
}
