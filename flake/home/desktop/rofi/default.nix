{ pkgs, default, ... }: {
  home.packages = with pkgs; [
    cliphist # Clipboard History
    keepmenu # Keepass integration
    wtype # Autotype
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = default.terminal.name;
    font = "${default.settings.font.default} 16";
    plugins = with pkgs; [ rofi-emoji rofi-calc ];

    theme = ./theme.rasi;
    extraConfig = {
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      window-format = "	{t:0}";
      sidebar-mode = true;
      display-drun = "Applications  ";
      display-window = "Tasks  ";
      display-emoji = "Emoji  ";
      display-calc = "Calc 󰃬";
      show-match = false;
      modi = "drun,window";

      # Keybindings
      kb-remove-to-eol = "";
      kb-mode-complete = "";
      kb-row-left = "Control+h";
      kb-row-right = "Control+l";
      kb-row-down = "Control+j,Control+n,Down";
      kb-row-up = "Control+k,Control+p,Up";
      kb-mode-previous = "Control+Alt+h,Control+Shift+Tab";
      kb-mode-next = "Control+Alt+l,Control+Tab";
      kb-remove-char-back = "BackSpace,Shift+BackSpace";
      kb-accept-entry = "Return,KP_Enter";
      kb-remove-word-back = "Control+BackSpace";
    };
  };

  xdg.configFile."keepmenu/config.ini".source =
    (pkgs.formats.ini { }).generate "config.ini" {
      dmenu = {
        dmenu_command = "rofi -l 8 -theme-str 'entry {placeholder: \"\";}'";
        title_path = false;
      };

      dmenu_passphrase = {
        obscure = true;
      };

      database = {
        database_1 = default.files.keepass;
        pw_cache_period_min = 360;
        autotype_default = "{USERNAME}{TAB}{PASSWORD}{ENTER}";
        type_library = "wtype";
      };
    };

  xdg.dataFile."rofi/themes/colors.rasi".text = ''
    * {
      background:           ${default.rgba.base00 0.7};
      background-selected:  ${default.rgba.base01 0.3};
      foreground:           ${default.xcolors.base05};
      foreground-selected:  ${default.xcolors.base08};
      placeholder-color:    ${default.rgba.extra04 0.5};
      accent:               ${default.xcolors.base08};
      base:                 ${default.xcolors.base02};
      background-color:     transparent;
    }
  '';
}
