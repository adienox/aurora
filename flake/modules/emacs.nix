{ config, pkgs, ... }: {
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
    client.enable = true;
    defaultEditor = true;
  };
}
