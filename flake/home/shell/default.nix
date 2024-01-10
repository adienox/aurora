{ config, default, ... }: {
  imports = [ ./zsh.nix ./xdg.nix ./cli.nix ./direnv.nix ./tmux.nix ];

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    EDITOR = default.editor;
    BROWSER = default.browser;
    FLAKE = default.files.flake;
    KEEPASSDB = default.files.keepass;

    ZELLIJ_AUTO_ATTACH = "true";
    ZELLIJ_AUTO_EXIT = "true";

    SUDO_ASKPASS =
      "${config.xdg.configHome}/assets/scripts/utils/zenity_askpass.sh";

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
  };
}
