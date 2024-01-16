{ default, ... }: {
  programs.wezterm = {
    enable = true;
    colorSchemes = {
      custom = {
        background = "${default.xcolors.background}";
        cursor_bg = "${default.xcolors.base06}";
        cursor_border = "${default.xcolors.base06}";
        cursor_fg = "${default.xcolors.background}";
        foreground = "${default.xcolors.foreground}";
        selection_bg = "${default.xcolors.base04}";
        selection_fg = "${default.xcolors.foreground}";
        split = "${default.xcolors.extra06}";
        ansi = [
          "${default.xcolors.base03}"
          "${default.xcolors.base08}"
          "${default.xcolors.base0B}"
          "${default.xcolors.base0A}"
          "${default.xcolors.base0D}"
          "${default.xcolors.extra00}"
          "${default.xcolors.base0C}"
          "${default.xcolors.extra04}"
        ];
        brights = [
          "${default.xcolors.base04}"
          "${default.xcolors.base08}"
          "${default.xcolors.base0B}"
          "${default.xcolors.base0A}"
          "${default.xcolors.base0D}"
          "${default.xcolors.extra00}"
          "${default.xcolors.base0C}"
          "${default.xcolors.extra05}"
        ];
        tab_bar = {
          background = "${default.xcolors.background}";
          active_tab = {
            bg_color = "${default.xcolors.base01}";
            fg_color = "${default.xcolors.foreground}";
          };
          inactive_tab = {
            bg_color = "${default.xcolors.background}";
            fg_color = "${default.xcolors.foreground}";
          };
          inactive_tab_hover = {
            bg_color = "${default.xcolors.base01}";
            fg_color = "${default.xcolors.foreground}";
          };
          inactive_tab_edge = "${default.xcolors.background}";
          new_tab = {
            bg_color = "${default.xcolors.background}";
            fg_color = "${default.xcolors.foreground}";
          };
          new_tab_hover = {
            bg_color = "${default.xcolors.base01}";
            fg_color = "${default.xcolors.foreground}";
          };
        };
      };
    };
    extraConfig = ''
      local wezterm = require ("wezterm")

      local function font_with_fallback(name, params)
        local names = { name, "Material Symbols Outlined"}
        return wezterm.font_with_fallback(names, params)
      end

      local font_name = "${default.terminal.font}"

      return {
        font_size = ${toString default.terminal.size},

       -- Font config
        font = font_with_fallback(font_name),
        font_rules = {
           {
             italic = true,
             font = font_with_fallback(font_name, { italic = true }),
           },
           {
             italic = false,
             font = font_with_fallback(font_name, { bold = true }),
           },
           {
             intensity = "Bold",
             font = font_with_fallback(font_name, { bold = true }),
           },
         },

        color_scheme = "custom",
        window_background_opacity = ${toString default.terminal.opacity},
        warn_about_missing_glyphs = false,
        enable_scroll_bar = false,
        enable_tab_bar = false,
        scrollback_lines = 10000,
        
        window_padding = {
          left = 5,
          right = 5,
          top = 5,
          bottom = 0,
        },
        
        enable_wayland = true,
        check_for_updates = false,
        default_cursor_style = "BlinkingUnderline",
        automatically_reload_config = true,
        bold_brightens_ansi_colors = true,
        window_close_confirmation = "NeverPrompt",

        disable_default_key_bindings = true,
        keys = {
          {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ PasteFrom = "Clipboard" }),
          },
          {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
          },
        },
      }
    '';
  };
}
