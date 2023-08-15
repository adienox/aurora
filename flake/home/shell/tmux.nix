{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    newSession = true;
    prefix = "C-s";
    shell = "\${pkgs.zsh}/bin/zsh";

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
      unbind r
      unbind C-l
      bind v split-window -h
      bind h split-window -v
      bind b set status

      set -g base-index 1           # start windows numbering at 1
      setw -g pane-base-index 1     # make pane numbering consistent with windows
      setw -g automatic-rename on   # rename window to reflect current program
      set -g renumber-windows on    # renumber windows when a window is closed
      set -g set-titles on          # set terminal title
      set-option -sa terminal-features ',xterm-kitty:RGB'
      set-option -g status-position top

      bind-key -r w run-shell "tmux neww ~/.config/assets/scripts/weather.sh"
    '';
  };
}
