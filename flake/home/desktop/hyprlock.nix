{ config, default, ... }: {
  programs.hyprlock = {
    enable = true;
    general = {
      grace = 3;
      hide_cursor = true;
    };
    backgrounds = [{
      path =
        "${config.xdg.userDirs.pictures}/backgrounds/minimal-squares-rosepine.png";
      blur_size = 8;
      blur_passes = 2;
      noise = 1.17e-2;
      contrast = 1.2;
      brightness = 1.0;
      vibrancy = 0.1696;
      vibrancy_darkness = 0.0;
    }];

    input-fields = [{
      outline_thickness = 2;
      dots_size = 0.2;
      dots_spacing = 0.2;
      dots_center = true;
      outer_color = "rgba(0, 0, 0, 0)";
      inner_color = "rgba(30, 30, 46, 0.3)";
      font_color = "rgb(${default.colors.foreground})";
      fade_on_empty = false;
      hide_input = false;
      placeholder_text =
        ''<i><span foreground="##ffffff99">The Password is?!</span></i>'';

      shadow_passes = 1;
      shadow_size = 5;
      shadow_boost = 0.5;

      size = {
        width = 270;
        height = 60;
      };
      position = {
        x = 0;
        y = -120;
      };
      halign = "center";
      valign = "center";
    }];

    labels = [
      {
        text = "$TIME";
        color = "rgb(${default.colors.foreground})";
        font_size = 125;
        font_family = "SF Pro Display Bold";

        shadow_passes = 1;
        shadow_size = 5;
        shadow_boost = 0.5;

        position = {
          x = 0;
          y = 200;
        };
        halign = "center";
        valign = "center";
      }

      {
        text = ''
          cmd[update:1000] echo "   $(cat /sys/class/power_supply/BAT0/capacity)%"'';
        color = "rgb(${default.colors.foreground})";
        font_size = 11;
        font_family = "SF Pro Display";

        shadow_passes = 1;
        shadow_size = 5;
        shadow_boost = 0.5;

        position = {
          x = -20;
          y = -20;
        };
        halign = "right";
        valign = "top";
      }

      {
        text = ''cmd[update:10000000] echo "   $USER"'';
        color = "rgb(${default.colors.foreground})";
        font_size = 11;
        font_family = "SF Pro Display";

        shadow_passes = 1;
        shadow_size = 5;
        shadow_boost = 0.5;

        position = {
          x = 20;
          y = -20;
        };
        halign = "left";
        valign = "top";
      }

      {
        text = ''
          <i><span foreground="##ffffff99">be present, be still, for it can be the last thing you ever experience</span></i>'';
        font_size = 14;
        font_family = "SF Pro Display";

        shadow_passes = 1;
        shadow_size = 5;
        shadow_boost = 0.5;

        position = {
          x = 0;
          y = 20;
        };
        halign = "center";
        valign = "bottom";
      }
    ];
  };
}
