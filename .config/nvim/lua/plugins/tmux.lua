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
      { '<c-w>h', '<cmd>TmuxNavigateLeft<cr>' },
      { '<c-w>j', '<cmd>TmuxNavigateDown<cr>' },
      { '<c-w>k', '<cmd>TmuxNavigateUp<cr>' },
      { '<c-w>l', '<cmd>TmuxNavigateRight<cr>' },
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
