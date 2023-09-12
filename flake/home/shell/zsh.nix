{ pkgs, ... }: {
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
        " --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
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

      p = "ipython - -no-banner - -no-confirm-exit";
      psv = "source ./venv/bin/activate";
      pcv = "python - m venv venv";

      gc = "git commit -m";
      ga = "git add";
      gp = "git push";
      gs = "git status";

      c = "source ~/.config/assets/scripts/cdier.sh";
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
        "curl -s 'https://api.quotable.io/quotes/random?tags=technology,famous-quotes' | gojq -r '.[0].content, .[0].author'";

      ls = "exa -al --color=always --group-directories-first --icons";
      la = "exa -a --color=always --group-directories-first --icons";
      ll = "exa -l --color=always --group-directories-first --icons";
      lt = "exa -aT --color=always --group-directories-first --icons";
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

      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      alias .....='cd ../../../..'
      alias ......='cd ../../../../..'
      alias tb="curl -F "file=@-" gcg.sh"

      if command -v zoxide &> /dev/null; then
          alias cd='z'
          alias zz='z -'
      fi

      if command -v docker &> /dev/null; then
          alias dps='docker ps -a'
          alias dc='docker'
          alias dci='docker images'
          alias dcp='docker container prune'
      fi

      if command -v tmux &> /dev/null; then
          alias tls='tmux list-sessions 2>/dev/null'
      fi

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
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
    '';
  };
}
