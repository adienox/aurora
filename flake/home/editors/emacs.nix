{ pkgs, ... }: {
  home.packages = with pkgs; [
    ispell
    nixfmt
    cmake
    gnumake
    gcc
    ripgrep
    fd
    nodejs
    ktlint
    black
    shellcheck
    shfmt
    html-tidy
    isort
  ];
  programs.emacs.enable = true;

  services.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    client.enable = true;
  };
}
