{pkgs, ...}: let
  nu_scripts = "${pkgs.nu_scripts}/share/nu_scripts";
in {
  home.packages = with pkgs; [
    fish
    vivid
  ];
  programs.nushell = {
    enable = true;
    shellAliases = {
      v = "nvim";
      cat = "bat";
      cls = "clear";

      p = "ipython --no-banner --no-confirm-exit";
      py = "python";

      tn = "tmux new -A -s \"home 🏡\"";

      ga = "git add";
      gp = "git push";
      gs = "git status";

      sudo = "sudo ";
      wget = "wget -c ";
      grep = "grep --color=auto";
      hw = "hwinfo --short";
      ipa = "ip --brief address";
      man = "BAT_THEME='default' batman";

      dv-create = "nix flake init --template github:cachix/devenv and direnv allow";
      dv-create-py = "nix flake init --template github:cachix/devenv and echo 'layout python' >> .envrc and direnv allow";

      pa = "pueue add";
      pbs = "pueue status";
      pf = "pueue follow";
    };
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    extraConfig = ''
      # modules
      use ${nu_scripts}/modules/nix/nix.nu *
      use ${nu_scripts}/modules/background_task/task.nu
      use ${nu_scripts}/modules/data_extraction/ultimate_extractor.nu
      use ${nu_scripts}/modules/network/sockets/sockets.nu

      # completions
      use ${nu_scripts}/custom-completions/nix/nix-completions.nu *
      use ${nu_scripts}/custom-completions/git/git-completions.nu *
      use ${nu_scripts}/custom-completions/bitwarden-cli/bitwarden-cli-completions.nu *

      source ${nu_scripts}/themes/nu-themes/catppuccin-mocha.nu

      ${builtins.readFile ./keybindings.nu}
      ${builtins.readFile ./snippets.nu}
      ${builtins.readFile ./completions.nu}
    '';
  };
}
