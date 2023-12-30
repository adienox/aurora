{ pkgs, ... }: {
  programs.neovim = { enable = true; };

  home.packages = with pkgs; [
    # lua stuff
    lua-language-server
    stylua

    # nix stuff
    rnix-lsp
    nixfmt

    # python stuff
    python3
    nodePackages.pyright
    mypy
    ruff
    black

    # web-dev stuff
    prettierd
    nodePackages.typescript-language-server
    nodejs

    # needed for best functioning of nvim
    ripgrep
    gcc
    gnumake
    fzf
  ];
}
