{pkgs, ...}: let
  plugins-repo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "06e5fe1c7a2a4009c483b28b298700590e7b6784";
    hash = "sha256-jg8+GDsHOSIh8QPYxCvMde1c1D9M78El0PljSerkLQc=";
  };
in {
  home.packages = with pkgs; [unar];
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      manager = {
        show_hidden = true;
        show_symlink = false;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
      open = {
        rules = [
          {
            mime = "text/*";
            use = "edit";
          }
          {
            mime = "audio/*";
            use = "play-audio";
          }
          {
            mime = "video/*";
            use = "play-video";
          }
        ];
      };
      opener = {
        edit = [
          {
            run = "$EDITOR \"$@\"";
            block = true;
          }
        ];
        play-audio = [
          {
            run = "mpv --no-resume-playback --no-video \"$@\"";
            orphan = true;
          }
        ];
        play-video = [
          {
            run = "mpv --no-resume-playback \"$@\"";
            orphan = true;
          }
        ];
      };
    };

    plugins = {
      chmod = "${plugins-repo}/chmod.yazi";
      max-preview = "${plugins-repo}/max-preview.yazi";
      starship = pkgs.fetchFromGitHub {
        owner = "Rolv-Apneseth";
        repo = "starship.yazi";
        rev = "0a141f6dd80a4f9f53af8d52a5802c69f5b4b618";
        hash = "sha256-OL4kSDa1BuPPg9N8QuMtl+MV/S24qk5R1PbO0jgq2rA=";
      };
    };

    initLua = ''
      require("starship"):setup()

      function Status:name()
        local h = cx.active.current.hovered
        if not h then
          return ui.Span("")
        end

        local linked = ""
        if h.link_to ~= nil then
          linked = " -> " .. tostring(h.link_to)
        end
        return ui.Span(" " .. h.name .. linked)
      end
    '';

    keymap = {
      manager.prepend_keymap = [
        {
          on = ["T"];
          run = "plugin --sync max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = ["c" "m"];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = ["j"];
          run = ["plugin --sync arrow --args=1"];
          desc = "Move selection downwards; or wrap.";
        }
        {
          on = ["k"];
          run = ["plugin --sync arrow --args=-1"];
          desc = "Move selection upwards; or wrap.";
        }
        {
          on = ["l"];
          run = ["plugin smart-enter --sync" "escape --visual --select"];
          desc = "Enter the child directory; or open file.";
        }
        {
          on = ["L"];
          run = "plugin smart-enter --sync --args='detatch'";
          desc = "Open in new window.";
        }
      ];
    };
  };
  xdg.configFile = {
    "yazi/plugins/smart-enter.yazi/init.lua".text = ''
        return {
      	entry = function()
      		local h = cx.active.current.hovered
      		ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
      	end,
      }
    '';
    "yazi/plugins/arrow.yazi/init.lua".text = ''
      return {
      	entry = function(_, args)
      		local current = cx.active.current
      		local new = (current.cursor + args[1]) % #current.files
      		ya.manager_emit("arrow", { new - current.cursor })
      	end,
      }
    '';
  };
}
