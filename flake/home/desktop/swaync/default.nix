{ pkgs, default, ... }: {
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
      @define-color noti-border-color     ${default.xcolors.base03};
      @define-color noti-bg               ${default.xcolors.base00};
      @define-color noti-bg-darker        ${default.xcolors.base01};
      @define-color noti-bg-hover         ${default.xcolors.base02};
      @define-color noti-bg-focus         ${default.rgba.base02 0.6};
      @define-color noti-close-bg         rgba(255, 255, 255, 0.1);
      @define-color noti-close-bg-hover   rgba(255, 255, 255, 0.15);
      @define-color text-color            ${default.xcolors.base05};
      @define-color text-color-disabled   ${default.xcolors.base03};
      @define-color bg-selected           ${default.xcolors.base08};
    '';
  };
}
