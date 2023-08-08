{ config, pkgs, ... }: {
  home.packages = [ pkgs.material-symbols ];

  programs.wlogout = {
    enable = true;
    style = ./style.css;
    layout = [
      {
        label = "lock";
        action = "gtklock -d";
        text = "lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "save";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-session $USER";
        text = "logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "power_settings_new";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "bedtime";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "restart_alt";
        keybind = "r";
      }
    ];
  };
}
