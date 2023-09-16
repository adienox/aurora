{ ... }: {

  imports = [
    ./shell
    ./desktop
    ./editors
    ./terminal
    ./theme
    ./software
  ];

  home.username = "nox";
  home.homeDirectory = "/home/nox";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
