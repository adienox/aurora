{ ... }: {
  programs.git = {
    enable = true;
    userName = "Adienox";
    userEmail = "adwaitadk@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
    ignores = [ ".env" "*~" "*.swp" ];
  };
}
