{ default, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      right_format = "$cmd_duration";

      nix_shell = {
        impure_msg = "[impure](bold ${default.xcolors.base08})";
        pure_msg = "[pure](bold ${default.xcolors.base0B})";
        unknown_msg = "[unknown](bold ${default.xcolors.base0A})";
        format =
          "via [ $state( \\($name\\))](bold ${default.xcolors.base0D}) ";
      };

      git_status = {
        ahead = "󰶣";
        behind = "󰶡";
      };

      directory = {
        format = "[ ](bold ${default.xcolors.base0D})[ $path ]($style)";
        style = "bold ${default.xcolors.base07}";
      };

      directory.substitutions = {
        "~" = "󰋞";
        "Documents" = " ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };

      character = {
        success_symbol =
          "[ ](bold ${default.xcolors.base0D})[ ➜](bold ${default.xcolors.base0B})";
        error_symbol =
          "[ ](bold ${default.xcolors.base0D})[ ➜](bold ${default.xcolors.base08})";
        vimcmd_symbol =
          "[ ](bold ${default.xcolors.base0D})[ ](bold ${default.xcolors.base0B})";
        vimcmd_replace_one_symbol =
          "[ ](bold ${default.xcolors.base0D})[ ](bold ${default.xcolors.base0E})";
        vimcmd_replace_symbol =
          "[ ](bold ${default.xcolors.base0D})[ ](bold ${default.xcolors.base0E})";
        vimcmd_visual_symbol =
          "[ ](bold ${default.xcolors.base0D})[ ](bold ${default.xcolors.base0A})";
      };

      cmd_duration = {
        format =
          "[]($style)[[󰔚 ](bg:${default.xcolors.base02} fg:${default.xcolors.base0A} bold)$duration](bg:${default.xcolors.base02} fg:${default.xcolors.base05})[ ]($style)";
        disabled = false;
        style = "bg:none fg:${default.xcolors.base02}";
      };
    };
  };
}
