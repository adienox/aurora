{
  pkgs,
  default,
  ...
}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar
    bzip2
    gzip
    p7zip

    # Tmux
    tmux
    sesh
    gum

    # utils
    tdf
    pfetch
    file
    du-dust
    duf
    fd
    ripgrep
    trash-cli
    fzf
    tealdeer
    yt-dlp
    moreutils
  ];

  programs = {
    fzf = {
      enable = true;
      catppuccin.enable = false;
      enableZshIntegration = true;
      colors = {
        spinner = default.xcolors.base06;
        hl = default.xcolors.base08;
        fg = default.xcolors.base05;
        header = default.xcolors.base08;
        info = default.xcolors.base0E;
        pointer = default.xcolors.base06;
        marker = default.xcolors.base06;
        prompt = default.xcolors.base0E;
        "bg+" = default.xcolors.base02;
        "fg+" = default.xcolors.base05;
        "hl+" = default.xcolors.base08;
      };
    };

    carapace = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = {
        update_check = false;
        keymap_mode = "vim-normal";
        enter_accept = true;
        sync_records = true;
        auto_sync = true;
        sync_frequency = "5m";
        sync_address = "https://api.atuin.sh";
        show_help = false;
        show_tabs = false;
        inline_height = 20;
        filter_mode_shell_up_key_binding = "directory";
        history_filter = [
          "^cd"
          "^ls"
          "^y$"
          "^cls"
          "^rm"
          "^source"
        ];
      };
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
      extraPackages = with pkgs.bat-extras; [batman batgrep batwatch];
    };

    btop.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    ssh = {
      enable = true;
      extraConfig = ''
      '';
    };

    skim = {
      enable = true;
      catppuccin.enable = false;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'lsd --icon always --git --color always --tree --depth 3 {} | head -200'"
        "--exact"
      ];
    };

    lazygit = {
      enable = true;
      settings = {
        gui.theme = {
          activeBorderColor = [default.xcolors.base0E "bold"];
          inactiveBorderColor = [default.xcolors.extra05];
          optionsTextColor = [default.xcolors.base0D];
          selectedLineBgColor = [default.xcolors.base02];
          selectedRangeBgColor = [default.xcolors.base02];
          cherryPickedCommitBgColor = [default.xcolors.base03];
          cherryPickedCommitFgColor = [default.xcolors.base08];
          unstagedChangesColor = [default.xcolors.base08];
          defaultFgColor = [default.xcolors.base05];
          searchingActiveBorderColor = [default.xcolors.base0A];
        };
      };
    };
  };

  xdg.configFile = {
    "python/pythonrc".text = ''
      import readline
      readline.write_history_file = lambda *args: None
    '';
  };
}
