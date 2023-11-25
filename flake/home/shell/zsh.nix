{ pkgs, default, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";

    historySubstringSearch.enable = true;
    history = {
      extended = true;
      ignoreAllDups = true;
      ignorePatterns = [ "rm *" "pkill *" ];
      path = "$ZDOTDIR/.zsh_history";
      save = 1000000;
      size = 1000000;
    };

    localVariables = {
      FZF_DEFAULT_OPTS =
        " --color=bg+:${default.xcolors.base02},bg:${default.xcolors.base00},spinner:${default.xcolors.base06},hl:${default.xcolors.base08} --color=fg:${default.xcolors.base05},header:${default.xcolors.base08},info:${default.xcolors.base0E},pointer:${default.xcolors.base06} --color=marker:${default.xcolors.base06},fg+:${default.xcolors.base05},prompt:${default.xcolors.base0E},hl+:${default.xcolors.base08}";
    };

    completionInit = ''
      autoload -Uz compinit
      compinit -d ~/.cache/zcompdump
      zstyle ":completion:*:*:*:*:*" menu select
      zstyle ":completion:*" auto-description "specify: %d"
      zstyle ":completion:*" completer _expand _complete
      zstyle ":completion:*" list-colors ""
      zstyle ": completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"
      zstyle ":completion:*" rehash true
      zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s
      zstyle ":completion:*" use-compctl false
      zstyle ":completion:*" verbose true
      zstyle ":completion:*:kill:*" command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"
      _comp_options+=(globdots)
    '';

    shellAliases = {
      waybar_restart = "kill -SIGUSR2 $(pidof waybar)";

      p = "ipython --no-banner --no-confirm-exit";
      psv = "source ./venv/bin/activate";
      pcv = "python - m venv venv";

      gc = "git commit -m";
      ga = "git add";
      gp = "git push";
      gs = "git status";

      rm = "trash";
      cls = "clear";
      sf = "fc-list | grep -i";
      sudo = "sudo ";
      yt-audio = "yt-dlp -x --audio-format mp3 --audio-quality 0";
      speedtest =
        "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";
      v = "nvim";
      cat = "bat";
      wget = "wget -c ";
      grep = "grep --color=auto";
      hw = "hwinfo --short";
      ipa = "ip --brief address";
      quote =
        "curl -s 'https://api.quotable.io/quotes/random?tags=technology|famous-quotes|wisdom|success|courage|creativity&limit=1' | gojq -r '.[0].content, .[0].author'";
      man = "BAT_THEME='default' batman";

      ls = "eza -al --color=always --group-directories-first --icons";
      la = "eza -a --color=always --group-directories-first --icons";
      ll = "eza -l --color=always --group-directories-first --icons";
      lt = "eza -aT --color=always --group-directories-first --icons";

      cd = "z";
      zz = "z -";

      # dps = "docker ps -a";
      # dc = "docker";
      # dci = "docker images";
      # dcp = "docker container prune";

      tls = "tmux list-sessions 2>/dev/null";
    };

    initExtra = ''
      setopt interactivecomments # allow comments in interactive mode
      setopt magicequalsubst     # enable filename expansion for arguments of the form 'anything=expression'
      setopt nonomatch           # hide error message if there is no match for the pattern
      setopt notify              # report the status of background jobs immediately
      setopt numericglobsort     # sort filenames numerically when it makes sense
      setopt promptsubst         # enable command substitution in prompt

      # run programs that are not in PATH with comma
      command_not_found_handler() {
        ${pkgs.comma}/bin/comma "$@"
      }
      
      eval "$(direnv hook zsh)"

      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      alias .....='cd ../../../..'
      alias ......='cd ../../../../..'
      alias tb="curl -F "file=@-" gcg.sh"

      alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
      alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

      # runs fetch if shell is interactive and not inside vscode and nvim
      if [[ $- == *i* && "$TERM_PROGRAM" != "vscode" && -z "$VIM" ]] ; then
        $XDG_CONFIG_HOME/assets/scripts/fetch.sh
      fi

      # Vscode support in commandline
      [[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

      function zvm_config() {
        ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
        ZVM_VI_ESCAPE_BINDKEY=jk
      }

      # Plugins
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

      # press <C-v><UP> and <C-v><DOWN> at your ZSH command line prompt for correct key codes.
      bindkey '^[OA' history-substring-search-up
      bindkey '^[OB' history-substring-search-down

      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
    '';
  };
}
