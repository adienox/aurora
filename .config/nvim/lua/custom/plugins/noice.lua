return {
  'folke/noice.nvim',
  event = 'UiEnter',
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
        ['config.entry.get_documentation'] = true,
      },
    },

    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
            { find = '%d fewer lines' },
            { find = '%d more lines' },
            { find = 'No information available' },
          },
        },
        opts = { skip = true },
      },
    },

    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },

    format = {
      lsp_progress = {
        { '{data.progress.message} ', hl_group = 'NoiceLspProgress' },
        { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
      },
      lsp_progress_done = {
        { '✔ ', hl_group = 'NoiceLspProgressSpinner' },
        { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        background_colour = '#000000',
        render = 'compact',
      },
    },
  },
}
