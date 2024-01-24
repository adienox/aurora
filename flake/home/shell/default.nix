{ config, default, ... }: {
  imports = [
    ./zsh
    ./xdg.nix
    ./cli.nix
    ./direnv.nix
    ./tmux.nix
    ./zellij.nix
    ./lsd.nix
  ];

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    EDITOR = default.editor;
    BROWSER = default.browser;
    FLAKE = default.files.flake;
    KEEPASSDB = default.files.keepass;
    SUDO_ASKPASS =
      "${config.xdg.configHome}/assets/scripts/utils/zenity-askpass.sh";

    # Zellij attach variables
    ZELLIJ_AUTO_ATTACH = "true";
    ZELLIJ_AUTO_EXIT = "true";

    # Reducing direnv logs
    DIRENV_LOG_FORMAT = "";

    # ~/ Clean-up:
    XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

    ANDROID_SDK_HOME = "${config.xdg.configHome}/android";
    ANSIBLE_CONFIG = "${config.xdg.configHome}/ansible/ansible.cfg";
    MBSYNCRC = "${config.xdg.configHome}/mbsync/config";
    PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
    IPYTHONDIR = "${config.xdg.configHome}/ipython";

    ELECTRUMDIR = "${config.xdg.dataHome}/electrum";
    UNISON = "${config.xdg.dataHome}/unison";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GOPATH = "${config.xdg.dataHome}/go";
    SQLITE_HISTORY = "${config.xdg.dataHome}/sqlite_history";

    GOMODCACHE = "${config.xdg.cacheHome}/go/mod";

    SKIM_DEFAULT_OPTIONS = ''
      $SKIM_DEFAULT_OPTIONS 
      --color=fg:${default.xcolors.base05},matched:${default.xcolors.base02},matched_bg:${default.xcolors.base0F},current:${default.xcolors.base05},current_bg:${default.xcolors.base03},current_match:${default.xcolors.base00},current_match_bg:${default.xcolors.base06},spinner:${default.xcolors.base0B},info:${default.xcolors.base0E},prompt:${default.xcolors.base0D},cursor:${default.xcolors.base08},selected:${default.xcolors.extra01},header:${default.xcolors.base0C},border:${default.xcolors.extra06}'';
  };
}
