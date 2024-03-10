{ pkgs, ... }: {
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.variables = {
    #https://unix.stackexchange.com/a/657578
    LIBSEAT_BACKEND = "logind";
  };

  # hint electron apps to use wayland:
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs = {
    hyprland.enable = true;

    # make HM-managed GTK stuff work
    dconf.enable = true;
    seahorse.enable = true;
  };

  services = {
    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [ "CascadiaCode" "JetBrainsMono" "FantasqueSansMono" ];
      })
      (pkgs.fetchzip {
        url =
          "https://github.com/vercel/geist-font/releases/download/1.1.0/Geist.Mono.zip";
        hash = "sha256-8I4O2+bJAlUiDIhbyXzAcwXP5qpmHoh4IfrFio7IZN8=";
        stripRoot = false;
      })
      font-awesome
      google-fonts
      apple-fonts
    ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };
}
