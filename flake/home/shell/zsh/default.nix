{
  config,
  pkgs,
  ...
}:
{
  xdg.configFile."zsh/modules/termsupport.zsh".source = ./termsupport.zsh;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";

    historySubstringSearch.enable = true;
    history = {
      extended = true;
      ignoreAllDups = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
      ];
      path = "$ZDOTDIR/.zsh_history";
      save = 1000000;
      size = 1000000;
    };

    completionInit = ''
      # autoload -Uz compinit
      # if [[ -n $(print ~/.cache/zcompdump(Nmh+24)) ]]; then
      #   # Regenerate completions because the dump file hasn't been modified within the last 24 hours
      #   compinit -d ~/.cache/zcompdump
      # else
      #   # Reuse the existing completions file
      #   compinit -C -d ~/.cache/zcompdump
      # fi
      zstyle ":completion:*:*:*:*:*" menu select
      zstyle ":completion:*" list-colors ""
      zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"
      _comp_options+=(globdots)
    '';

    shellAliases = {
      p = "ipython --no-banner --no-confirm-exit";
      py = "python";
      psv = "source ./venv/bin/activate";
      pcv = "python -m venv venv";

      v = "nvim";
      vo = "nvim \"+Telescope find_files\"";

      tls = "tmux list-sessions 2>/dev/null";
      tn = "tmux new -A -s \"home 🏡\"";

      gc = "git commit -m";
      ga = "git add";
      gp = "git push";
      gs = "git status";

      rm = "trash";
      cls = "clear";
      sf = "fc-list | grep -i";
      sudo = "sudo ";
      yt-audio = "yt-dlp -x --audio-format mp3 --audio-quality 0";
      # speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";
      cat = "bat";
      wget = "wget -c ";
      grep = "grep --color=auto";
      hw = "hwinfo --short";
      ipa = "ip --brief address";
      man = "BAT_THEME='default' batman";

      ls = "lsd -l";

      cd = "z";
      zz = "z -";

      jq = "gojq";

      # dps = "docker ps -a";
      # dc = "docker";
      # dci = "docker images";
      # dcp = "docker container prune";

      dv-create = "nix flake init --template github:cachix/devenv && direnv allow";
      dv-create-py = "nix flake init --template github:cachix/devenv && echo 'layout python' >> .envrc && direnv allow";

      pa = "pueue add";
      pbs = "pueue status";
      pf = "pueue follow";
    };

    initExtra = ''
      # run programs that are not in PATH with comma
      command_not_found_handler() {
          ${pkgs.comma}/bin/comma "$@"
      }
      ${builtins.readFile ./config.zsh}
      # Plugins
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      source ${config.xdg.configHome}/zsh/modules/termsupport.zsh
      export LS_COLORS=$(${pkgs.vivid}/bin/vivid generate catppuccin-mocha)
    '';

  };
}
