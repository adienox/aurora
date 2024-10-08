{
  config,
  pkgs,
  ...
}: {
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
      ignorePatterns = ["rm *" "pkill *"];
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

      alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
      alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

      # runs fetch if shell is interactive and not inside vscode and nvim
      # if [[ $- == *i* && "$TERM_PROGRAM" != "vscode" && -z "$VIM" ]] ; then
      #   #$XDG_CONFIG_HOME/assets/scripts/fetch.sh
      #   maxfetch
      # fi

      # Plugins
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      # source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      source ${config.xdg.configHome}/zsh/modules/termsupport.zsh

      # press <C-v><UP> and <C-v><DOWN> at your ZSH command line prompt for correct key codes.
      # bindkey '^[OA' history-substring-search-up
      # bindkey '^[OB' history-substring-search-down

      # bindkey -M vicmd 'k' history-substring-search-up
      # bindkey -M vicmd 'j' history-substring-search-down
    '';
  };
}
