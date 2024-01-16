{ pkgs, inputs, default, ... }:
let
  status-bar = ''
    pane size=1 borderless=true {
        plugin location="file:${
          inputs.zjstatus.packages.${pkgs.system}.default
        }/bin/zjstatus.wasm" {
          format_left  "{mode} #[fg=${default.xcolors.base0D},bold]{session} {tabs}"
          format_right "{datetime}"
          format_space ""
          
          hide_frame_for_single_pane "true"

          mode_normal        ""
          mode_locked        "#[fg=${default.xcolors.base08}] {name}"
          mode_resize        "#[fg=${default.xcolors.base08}] {name}"
          mode_pane          "#[fg=${default.xcolors.base08}] {name}"
          mode_tab           "#[fg=${default.xcolors.base08}] {name}"
          mode_scroll        "#[fg=${default.xcolors.base08}] {name}"
          mode_enter_search  "#[fg=${default.xcolors.base08}] {name}"
          mode_search        "#[fg=${default.xcolors.base08}] {name}"
          mode_rename_tab    "#[fg=${default.xcolors.base08}] {name}"
          mode_rename_pane   "#[fg=${default.xcolors.base08}] {name}"
          mode_session       "#[fg=${default.xcolors.base08}] {name}"
          mode_move          "#[fg=${default.xcolors.base08}] {name}"
          mode_prompt        "#[fg=${default.xcolors.base08}] {name}"
          mode_tmux          "#[fg=${default.xcolors.base0A}] {name}"

          // formatting for inactive tabs
          tab_normal              "#[fg=${default.xcolors.extra06}]{name} "
          tab_normal_fullscreen   "#[fg=${default.xcolors.extra06}]{name} 󱡴 "
          tab_normal_sync         "#[fg=${default.xcolors.extra06}]{name} 󱑡 "

          // formatting for the current active tab
          tab_active              "#[fg=${default.xcolors.extra04},bold,italic]{name} "
          tab_active_fullscreen   "#[fg=${default.xcolors.extra04},bold,italic]{name} 󱡴 "
          tab_active_sync         "#[fg=${default.xcolors.extra04},bold,italic]{name} 󱑡 "

          datetime        "#[fg=${default.xcolors.extra06},bold] {format}"
          datetime_format "%A, %d %b %Y %H:%M"
          datetime_timezone "Asia/Kathmandu"
        }
    }
  '';

in {
  programs.zellij.enable = true;

  xdg.configFile = {
    "zellij/layouts/system-configuration.kdl".text = ''
      layout {
        tab name="System config" {
          pane split_direction="vertical" {
            pane {
              cwd "~/aurora/"
              command "nvim"
            }
            pane command="nh" {
              args "home" "switch"
              start_suspended true
              name "nh"
            }
          }
          ${status-bar}
        }
      }
    '';
    "zellij/layouts/default.kdl".text = ''
      layout {
          pane split_direction="vertical" {
              pane
          }
      ${status-bar}
      }
    '';

    "zellij/themes/default.kdl".text = ''
      themes {
        default {
          bg "${default.xcolors.base04}"
          fg "${default.xcolors.base05}"
          red "${default.xcolors.base08}"
          green "${default.xcolors.base0E}" // border-color
          blue "${default.xcolors.base0D}"
          yellow "${default.xcolors.base0A}"
          magenta "${default.xcolors.extra00}"
          orange "${default.xcolors.base09}"
          cyan "${default.xcolors.extra02}"
          black "${default.xcolors.base02}"
          white "${default.xcolors.base05}"
        }
      }
    '';
  };
}
