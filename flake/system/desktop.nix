{ config, lib, pkgs, ... }: {
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.variables = {
    #https://unix.stackexchange.com/a/657578
    LIBSEAT_BACKEND = "logind";
  };

  # Using https://github.com/samuelngs/apple-emoji-linux Apple Color Emoji as the default emoji font. Download and place it in ~$HOME/.local/share/fonts~
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ nerdfonts font-awesome google-fonts ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };
}