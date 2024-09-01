{pkgs, ...}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      update_check = false;
      keymap_mode = "vim-normal";
      enter_accept = true;
      sync_records = true;
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      show_help = false;
      show_tabs = false;
      inline_height = 20;
      filter_mode_shell_up_key_binding = "directory";
      daemon = {enabled = true;};
      history_filter = [
        "^cd"
        "^z "
        "^ls"
        "^mv"
        "^cp"
        "^y$"
        "^cls"
        "^clear"
        "^rm"
        "^source"
        "^package-locate"
      ];
    };
  };
  systemd.user.services = {
    atuin = {
      Unit = {
        Description = "Atuin daemon";
        PartOf = ["default.target"];
        After = ["network.target"];
      };
      Service = {
        ExecStart = "${pkgs.atuin}/bin/atuin daemon";
        Restart = "on-failure";
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
