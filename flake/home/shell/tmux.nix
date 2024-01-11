{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    newSession = true;
    prefix = "C-s";
    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
      unbind r
      bind v split-window -h
      bind s split-window -v
      bind b set status

      set-option -g terminal-overrides ',xterm-256color:RGB'

      set -g base-index 1           # start windows numbering at 1
      set -g renumber-windows on    # renumber windows when a window is closed
      set -g set-titles on          # set terminal title
      set -g escape-time 0          # zero-out escape time
      set -g set-clipboard on       # use system clipboard
      set -g status-position top    # top status bar

      setw -g pane-base-index 1     # make pane numbering consistent with windows
      setw -g automatic-rename on   # rename window to reflect current program
    '';
  };
}
