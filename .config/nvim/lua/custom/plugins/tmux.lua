return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  {
    'samharju/yeet.nvim',
    dependencies = {
      'stevearc/dressing.nvim', -- optional, provides sane UX
    },
    cmd = 'Yeet',
    opts = {
      notify_on_success = false,
    },
    keys = {
      {
        '\\\\',
        mode = { 'n' },
        function()
          require('yeet').execute()
        end,
        desc = 'Yeet Execute',
      },
    },
  },
}
