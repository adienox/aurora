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

    sops
    age

    # utils
    gum
    glow
    charm-freeze
    mods
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
    zathura = {
      enable = true;
      extraConfig = ''
        set default-bg          ${default.rgba.base00 0.7}
        set statusbar-bg        ${default.rgba.base00 0.7}
        set index-active-bg     ${default.rgba.base00 0.7}
        set inputbar-bg         ${default.rgba.base00 0.7}
        set render-loading-bg   ${default.rgba.base00 0.7}
        set recolor             "false"
        set database            "sqlite"
      '';
    };
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
      enableNushellIntegration = false; # using custom login look nushell/completions
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
        gui = {
          theme = {
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
          border = "single";
          nerdFontsVersion = "3";
          showPanelJumps = false;
          showBottomLine = false;
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
