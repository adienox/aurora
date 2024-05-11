---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
  theme = "catppuccin",
  transparency = true,

  extended_integrations = { "trouble", "hop", "todo", "notify", "rainbowdelimiters" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "minimal",       -- default/vscode/vscode_colored/minimal
    separator_style = "round", -- default/round/block/arrow
    overriden_modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    show_numbers = false,
    enabled = false,
    lazyload = true,
    overriden_modules = nil,
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default",          -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "default",   -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

  telescope = {
    style = "bordered",
  }, -- borderless / bordered

  nvdash = {
    load_on_startup = true,
  },
}

M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M
