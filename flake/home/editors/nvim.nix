{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    catppuccin.enable = false;
    extraLuaPackages = ps: [ps.magick ps.jsregexp];
    extraPackages = with pkgs; [imagemagick nodejs];
  };

  home.packages = with pkgs; [
    # lua stuff
    stylua
    luajitPackages.luarocks
    lua

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

    # go stuff
    goimports-reviser
    golines
    gofumpt

    # web-dev stuff
    prettierd
    emmet-ls
    # vscode-langservers-extracted
    tailwindcss-language-server

    # shell stuff
    shellcheck
    shfmt

    # db stuff
    sqlite

    # latex stuff
    python312Packages.pylatexenc

    # needed for best functioning of nvim
    tree-sitter
    ripgrep
    gcc
    gnumake
    fzf
  ];
}
