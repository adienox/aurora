{ config, pkgs, ... }: {
  services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;
    matches = {
      default = {
        matches = [{
          trigger = ";cite";
          replace = "— <cite></cite>";
        }];
      };
    };
  };
}
