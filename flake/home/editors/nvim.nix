{ pkgs, ... }: {
  programs.neovim = { enable = true; };

  home.packages = with pkgs; [
    # lua stuff
    stylua

    # nix stuff
    nixfmt

    # python stuff
    python3
    nodePackages.pyright
    python311Packages.ipython
    mypy
    ruff
    black
    isort

    # web-dev stuff
    prettierd
    emmet-ls

    # shell stuff
    shellcheck
    shfmt

    # db stuff
    sqlite

    # needed for best functioning of nvim
    tree-sitter
    ripgrep
    gcc
    gnumake
    fzf
  ];
}
