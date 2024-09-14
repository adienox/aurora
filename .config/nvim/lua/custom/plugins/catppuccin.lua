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
        RenderMarkdownLink = { fg = colors.mauve, style = { 'underline' } },
        Label = { fg = colors.mauve, style = { 'underline' } },
        RenderMarkdownH1Bg = { bg = '#000000' },
        RenderMarkdownH2Bg = { bg = '#000000' },
        RenderMarkdownH3Bg = { bg = '#000000' },
        RenderMarkdownH4Bg = { bg = '#000000' },
        RenderMarkdownH5Bg = { bg = '#000000' },
        RenderMarkdownH6Bg = { bg = '#000000' },
        NoiceLspProgress = { link = 'NonText' },
        NoiceLspProgressTitle = { link = 'Constant' },
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
