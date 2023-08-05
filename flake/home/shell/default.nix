{ config, pkgs, ... }: {
  imports = [
    ./zoxide.nix
    ./zsh.nix
    ./starship.nix
    ./xdg.nix
    ./cli.nix
  ];
  home.sessionVariables = {
    # ~/ Clean-up:
    XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";
    EDITOR = "code";
    BROWSER = "librewolf";

    TMUX_TMPDIR = "$XDG_RUNTIME_DIR";
    ANDROID_SDK_HOME = "$XDG_CONFIG_HOME/android";
    ANSIBLE_CONFIG = "$XDG_CONFIG_HOME/ansible/ansible.cfg";
    UNISON = "$XDG_DATA_HOME/unison";
    MBSYNCRC = "$XDG_CONFIG_HOME/mbsync/config";
    ELECTRUMDIR = "$XDG_DATA_HOME/electrum";

    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    GOPATH = "$XDG_DATA_HOME/go";
    GOMODCACHE = "$XDG_CACHE_HOME/go/mod";
    PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/pythonrc";
    IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
    SQLITE_HISTORY = "$XDG_DATA_HOME/sqlite_history";
  };
}
