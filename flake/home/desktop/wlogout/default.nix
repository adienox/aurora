{pkgs, ...}: {
  home.packages = [pkgs.material-symbols];

  programs.wlogout = {
    enable = true;
    style = ./style.css;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
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
        action = "loginctl terminate-user $USER";
        text = "logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "power_settings_new";
        keybind = "o";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "bedtime";
        keybind = "s";
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
