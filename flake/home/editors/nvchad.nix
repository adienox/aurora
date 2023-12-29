{ pkgs, ... }: {
  programs.neovim = { enable = true; };

  home.packages = with pkgs; [
    # lua stuff
    lua-language-server
    stylua

    # nix stuff
    rnix-lsp
    nixfmt

    prettierd
    ripgrep
    nodejs
    python3
    gcc
    gnumake
    fzf
    nodePackages.typescript-language-server
  ];
}
