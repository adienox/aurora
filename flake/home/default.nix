{ ... }: {

  imports = [ ./desktop ./editors ./shell ./software ./terminal ./theme ];

  home.username = "nox";
  home.homeDirectory = "/home/nox";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
