{ pkgs, default, ... }: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar
    tmux

    # utils
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
  ];

  programs = {
    fzf = {
      enable = true;
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

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Catppuccin-mocha";
      };
      themes = {
        Catppuccin-mocha = builtins.readFile (pkgs.fetchurl {
          url =
            "https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme";
          hash = "sha256-UDJ6FlLzwjtLXgyar4Ld3w7x3/zbbBfYLttiNDe4FGY=";
        });
      };
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };

    btop.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    ssh.enable = true;

    skim = {
      enable = true;
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
          activeBorderColor = [ default.xcolors.base0E "bold" ];
          inactiveBorderColor = [ default.xcolors.extra05 ];
          optionsTextColor = [ default.xcolors.base0D ];
          selectedLineBgColor = [ default.xcolors.base02 ];
          selectedRangeBgColor = [ default.xcolors.base02 ];
          cherryPickedCommitBgColor = [ default.xcolors.base03 ];
          cherryPickedCommitFgColor = [ default.xcolors.base08 ];
          unstagedChangesColor = [ default.xcolors.base08 ];
          defaultFgColor = [ default.xcolors.base05 ];
          searchingActiveBorderColor = [ default.xcolors.base0A ];
        };
      };
    };
  };

  xdg.configFile = {
    "btop/themes/catppuccin_mocha.theme".source = pkgs.fetchurl {
      url =
        "https://raw.githubusercontent.com/catppuccin/btop/7109eac2884e9ca1dae431c0d7b8bc2a7ce54e54/themes/catppuccin_mocha.theme";
      hash = "sha256-KnXUnp2sAolP7XOpNhX2g8m26josrqfTycPIBifS90Y=";
    };
  };

  xdg.configFile = {
    "python/pythonrc".text = ''
      import readline
      readline.write_history_file = lambda *args: None
    '';
  };
}
