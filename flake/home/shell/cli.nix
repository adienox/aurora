{ pkgs, inputs, default, ... }: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

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
    inputs.nh.packages.${pkgs.system}.default
    yt-dlp
  ];

  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        right_format = "$cmd_duration";

        nix_shell = {
          impure_msg = "[impure](bold ${default.xcolors.base08})";
          pure_msg = "[pure](bold ${default.xcolors.base0B})";
          unknown_msg = "[unknown](bold ${default.xcolors.base0A})";
          format =
            "via [ $state( \\($name\\))](bold ${default.xcolors.base0D}) ";
        };

        git_status = {
          ahead = "󰶣";
          behind = "󰶡";
        };

        directory = {
          format = "[ ](bold ${default.xcolors.base0D})[ $path ]($style)";
          style = "bold ${default.xcolors.base07}";
        };

        character = {
          success_symbol =
            "[ ](bold ${default.xcolors.base0D})[ ➜](bold ${default.xcolors.base0B})";
          error_symbol =
            "[ ](bold ${default.xcolors.base0D})[ ➜](bold ${default.xcolors.base08})";
          vimcmd_symbol =
            "[ ](bold ${default.xcolors.base0D})[ ](bold ${default.xcolors.base0B})";
          vimcmd_replace_one_symbol =
            "[ ](bold ${default.xcolors.base0D})[ ](bold ${default.xcolors.base0E})";
          vimcmd_replace_symbol =
            "[ ](bold ${default.xcolors.base0D})[ ](bold ${default.xcolors.base0E})";
          vimcmd_visual_symbol =
            "[ ](bold ${default.xcolors.base0D})[ ](bold ${default.xcolors.base0A})";
        };

        cmd_duration = {
          format =
            "[]($style)[[󰔚 ](bg:${default.xcolors.base02} fg:${default.xcolors.base0A} bold)$duration](bg:${default.xcolors.base02} fg:${default.xcolors.base05})[ ]($style)";
          disabled = false;
          style = "bg:none fg:${default.xcolors.base02}";
        };
      };
    };

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
            "https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme";
          hash = "sha256-qMQNJGZImmjrqzy7IiEkY5IhvPAMZpq0W6skLLsng/w=";
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
      changeDirWidgetOptions =
        [ "--preview 'lsd --git --tree --depth 3 | head -200'" "--exact" ];
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
