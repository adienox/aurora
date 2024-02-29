{ config, default, ... }: {
  programs.hyprlock = {
    enable = true;
    backgrounds = [{
      path = "${config.xdg.userDirs.pictures}/backgrounds/car.png";
      blur_size = 8;
      blur_passes = 3;
      noise = 1.17e-2;
      contrast = 1.2;
      brightness = 1.0;
      vibrancy = 0.1696;
      vibrancy_darkness = 0.0;
    }];

    input-fields = [{
      outline_thickness = 1;
      dots_size = 0.33;
      dots_spacing = 0.15;
      dots_center = true;
      outer_color = "rgb(151515)";
      inner_color = "rgb(${default.colors.background})";
      font_color = "rgb(${default.colors.foreground})";
      fade_on_empty = true;
      hide_input = false;

      size = {
        width = 200;
        height = 50;
      };
      position = {
        x = 0;
        y = -20;
      };
      halign = "center";
      valign = "center";
    }];

    labels = [{
      text = "$TIME";
      color = "rgb(${default.colors.foreground})";
      font_size = 125;
      font_family = "Noto Sans";

      position = {
        x = 0;
        y = 200;
      };
      halign = "center";
      valign = "center";
    }];
  };
}
