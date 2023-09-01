{ pkgs, ... }: {
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.variables = {
    #https://unix.stackexchange.com/a/657578
    LIBSEAT_BACKEND = "logind";
  };

  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = [ "/share/zsh" ];

  # hint electron apps to use wayland:
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs = {
    hyprland.enable = true;

    command-not-found.enable = false;

    nix-index = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

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
      (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" ]; })
      font-awesome
      google-fonts
    ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };
}
