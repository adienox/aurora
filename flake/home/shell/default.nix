{ config, default, ... }: {
  imports = [ ./zsh.nix ./xdg.nix ./cli.nix ./direnv.nix ./tmux.nix ];

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";

    # Reducing direnv logs
    DIRENV_LOG_FORMAT = "";

    # ~/ Clean-up:
    XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";
    EDITOR = default.editor;
    BROWSER = default.browser;
    FLAKE = default.files.flake;

    ZELLIJ_AUTO_ATTACH = "true";
    ZELLIJ_AUTO_EXIT = "true";

    ANDROID_SDK_HOME = "${config.xdg.configHome}/android";
    ANSIBLE_CONFIG = "${config.xdg.configHome}/ansible/ansible.cfg";
    UNISON = "${config.xdg.dataHome}/unison";
    MBSYNCRC = "${config.xdg.configHome}/mbsync/config";
    ELECTRUMDIR = "${config.xdg.dataHome}/electrum";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GOPATH = "${config.xdg.dataHome}/go";
    GOMODCACHE = "${config.xdg.cacheHome}/go/mod";
    PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
    IPYTHONDIR = "${config.xdg.configHome}/ipython";
    SQLITE_HISTORY = "${config.xdg.dataHome}/sqlite_history";
  };
}
