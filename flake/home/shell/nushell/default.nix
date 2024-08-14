{pkgs, ...}: let
  nu_scripts = "${pkgs.nu_scripts}/share/nu_scripts";
in {
  programs.nushell = {
    enable = true;
    shellAliases = {
      v = "nvim";
      cat = "bat";
      cls = "clear";
    };
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    extraConfig = ''
      # modules
      use ${nu_scripts}/modules/nix/nix.nu *
      use ${nu_scripts}/modules/background_task/task.nu
      source ${nu_scripts}/themes/nu-themes/catppuccin-mocha.nu

      ${builtins.readFile ./keybindings.nu}
      ${builtins.readFile ./snippets.nu}
    '';
  };
}
