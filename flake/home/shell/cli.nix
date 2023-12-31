{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # utils
    file
    du-dust
    duf
    fd
    ripgrep
    trash-cli
    fzf
    eza
    tealdeer
    inputs.nh.packages.${pkgs.system}.default
    yt-dlp
  ];

  programs = {
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
      changeDirWidgetOptions = [
        "--preview 'eza --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
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
