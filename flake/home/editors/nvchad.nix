{ pkgs, ... }: {
  programs.neovim = { enable = true; };

  home.packages = with pkgs; [
    # lua stuff
    lua-language-server
    stylua

    # nix stuff
    nixfmt
    nil

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
    nodePackages.typescript-language-server
    vscode-langservers-extracted
    emmet-ls
    tailwindcss-language-server

    # shell stuff
    nodePackages.bash-language-server
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
