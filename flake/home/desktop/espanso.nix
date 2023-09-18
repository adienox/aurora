{ pkgs, ... }: {
  services.espanso = {
    enable = true;
    package = pkgs.espanso;
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
