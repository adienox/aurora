{ config, lib, pkgs, ... }:
let
  colors = config.colorScheme.colors;
  colorlib = import ../../theme/libs.nix lib;
in {
  home.packages = with pkgs; [ swaynotificationcenter ];

  xdg.configFile."swaync/config.json".source =
    (pkgs.formats.json { }).generate "config.json" {
      notification-margin-top = 12;
      layer = "overlay";
      cssPriority = "user";
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;
      notification-window-width = 300;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      script-fail-notify = true;

      widgets = [ "title" "dnd" "mpris" "notifications" ];

      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = { text = "Do Not Disturb"; };
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
      };
    };

  xdg.configFile."swaync/style.css".source = ./style.css;

  xdg.configFile = {
    "swaync/colors.css".text = ''
      @define-color noti-border-color #${colors.base03};
      @define-color noti-bg #${colors.base00};
      @define-color noti-bg-darker #${colors.base01};
      @define-color noti-bg-hover #${colors.base02};
      @define-color noti-bg-focus ${colorlib.rgba colors.base02 0.6};
      @define-color noti-close-bg rgba(255, 255, 255, 0.1);
      @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);
      @define-color text-color #${colors.base05};
      @define-color text-color-disabled #${colors.base03};
      @define-color bg-selected #${colors.base08};
    '';
  };
}
