{
  default,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    newSession = true;
    mouse = true;
    keyMode = "vi";
    escapeTime = 0;
    shell = "${default.terminal.shell}";
    terminal = "tmux-256color";
    catppuccin.enable = false;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
      tmux-fzf
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          resurrect_dir="$HOME/.config/tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-hook-post-save-all "sed 's/--cmd[^ ]* [^ ]* [^ ]*//g' $resurrect_dir/last | sponge $resurrect_dir/last"
          set -g @resurrect-processes '"~nvim"'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
