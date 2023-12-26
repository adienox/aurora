{ pkgs, ... }: {
  programs.neovim = { enable = true; };

  home.packages = with pkgs; [
    rnix-lsp
    nil
    nixfmt
    ripgrep
    stylua
    nodejs
    python3
    gcc
    gnumake
    fzf
    deno
  ];
}
