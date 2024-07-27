{
  config,
  default,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 3;
        hide_cursor = true;
      };
      background = [
        {
          monitor = "";
          path = "${config.xdg.cacheHome}/background";
          blur_size = 7;
          blur_passes = 3;
          noise = 1.17e-2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          monitor = "";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(30, 30, 46, 0.3)";
          font_color = "rgb(${default.colors.foreground})";
          fade_on_empty = false;
          hide_input = false;
          placeholder_text = ''<i><span foreground="##ffffff99">The Password is?!</span></i>'';

          shadow_passes = 5;
          shadow_size = 10;
          shadow_boost = 0.5;

          size = "270, 60";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];

      image = {
        monitor = "";
        path = "${config.xdg.userDirs.pictures}/profile.png";
        size = 280; # lesser side if not 1:1 ratio;
        rounding = -1; # negative values mean circle;
        border_size = 4;
        border_color = "rgba(30, 30, 46, 0.3)";
        rotate = 0; # degrees, counter-clockwise;
        reload_time = -1; # seconds between reloading, 0 to reload with SIGUSR2;
        position = "0, 200";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(${default.colors.foreground})";
          font_size = 55;
          font_family = "Fira Semibold";

          shadow_passes = 5;
          shadow_size = 10;
          shadow_boost = 0.5;

          position = "-100, 70";
          halign = "right";
          valign = "bottom";
        }

        {
          monitor = "";
          text = "$USER";
          color = "rgb(${default.colors.foreground})";
          font_size = 20;
          font_family = "Fira Semibold";

          shadow_passes = 5;
          shadow_size = 10;
          shadow_boost = 0.5;

          position = "-100, 160";
          halign = "right";
          valign = "bottom";
        }

        # {
        #   text = ''
        #     <i><span foreground="##ffffff99">be present, be still, for it can be the last thing you ever experience</span></i>'';
        #   font_size = 14;
        #   font_family = "SF Pro Display";
        #
        #   shadow_passes = 1;
        #   shadow_size = 5;
        #   shadow_boost = 0.5;
        #
        #   position = "0, 20";
        #   halign = "center";
        #   valign = "bottom";
        # }
      ];
    };
  };
}
