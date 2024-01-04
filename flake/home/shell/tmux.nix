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
      unbind C-l
      bind v split-window -h
      bind s split-window -v
      bind b set status

      set-option -g terminal-overrides ',xterm-256color:RGB'

      set -g base-index 1           # start windows numbering at 1
      set -g renumber-windows on    # renumber windows when a window is closed
      set -g set-titles on          # set terminal title
      set -g detatch-on-destroy off # don't exit from tmux when closing a session
      set -g escape-time 0          # zero-out escape time
      set -g history-size 10000     # increase history size (from 2000)
      set -g set-clipboard on       # use system clipboard
      set -g status-position top    # top status bar

      setw -g pane-base-index 1     # make pane numbering consistent with windows
      setw -g automatic-rename on   # rename window to reflect current program
      setw -g mode-keys vi

      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
      set -g @catppuccin_status_modules_right "directory meetings date_time"
      set -g @catppuccin_status_modules_left "session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator " "
      set -g @catppuccin_status_right_separator_inverse "no"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_directory_text "#{b:pane_current_path}"
      set -g @catppuccin_meetings_text "#($HOME/.config/tmux/scripts/cal.sh)"
      set -g @catppuccin_date_time_text "%H:%M"
    '';
  };
}
