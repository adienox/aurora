{ ... }: {

  imports = [ ./desktop ./editors ./shell ./software ./terminal ./theme ];

  home.username = "nox";
  home.homeDirectory = "/home/nox";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  #FIXME: Remove this once its fixed
  nixpkgs.config.permittedInsecurePackages = [ "electron-22.3.27" ];
}
