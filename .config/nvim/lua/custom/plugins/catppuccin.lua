return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    transparent_background = true,
    integrations = {
      notify = true,
      fidget = true,
      lsp_saga = true,
      noice = true,
      lsp_trouble = true,
      which_key = true,
    },
    custom_highlights = function(colors)
      return {
        UfoFoldedEllipsis = { fg = colors.overlay2, bg = colors.none },
        TabLineSel = { bg = colors.pink },
        CmpBorder = { fg = colors.surface2 },
        Pmenu = { bg = colors.none },
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=none'
  end,
}
