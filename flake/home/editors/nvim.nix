{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    catppuccin.enable = false;
  };

  home.packages = with pkgs; [
    # lua stuff
    stylua

    # nix stuff
    alejandra

    # python stuff
    python3
    # nodePackages.pyright
    python311Packages.ipython
    mypy
    ruff
    black
    isort

    # web-dev stuff
    prettierd
    emmet-ls
    vscode-langservers-extracted
    tailwindcss-language-server

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
