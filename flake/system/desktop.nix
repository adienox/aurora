{ config, lib, pkgs, ... }: {
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
  programs.hyprland.enable = true;

  xdg.portal.enable = true;

  # Using https://github.com/samuelngs/apple-emoji-linux Apple Color Emoji as the default emoji font. Download and place it in ~$HOME/.local/share/fonts~
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ nerdfonts font-awesome google-fonts ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };
}
