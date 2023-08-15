{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    cliphist # Clipboard History
    keepmenu # Keepass integration
    wtype # Autotype
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    font = "Readex Pro 16";
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
    ];

    theme = ./theme.rasi;
    extraConfig = {
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      window-format = "\t{t:0}";
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

  xdg.configFile."Kvantum/config.ini".source =
    (pkgs.formats.ini { }).generate "config.ini" {
      dmenu = {
        dmenu_command = "rofi -l 8 -theme-str 'entry {placeholder: \"\";}'";
        title_path = false;
      };

      dmenu_passphrase = {
        obscure = true;
        obscure_color = "#222222";
      };

      database = {
        database_1 = "~/Documents/vault/armoury.kdbx";
        pw_cache_period_min = 360;
        autotype_default = "{USERNAME}{TAB}{PASSWORD}{ENTER}";
        type_library = "wtype";
      };
    };
}



