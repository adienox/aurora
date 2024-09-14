return {
  { 'numToStr/Comment.nvim', event = 'VeryLazy', opts = {} },

  {
    'mbbill/undotree',
    keys = {
      {
        '<leader>tu',
        mode = { 'n' },
        '<cmd>UndotreeToggle<CR>',
        desc = '[U]ndo Tree',
      },
    },
  },

  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'TroubleToggle',
    keys = {
      {
        '<leader>tt',
        mode = { 'n' },
        '<cmd>TroubleToggle<CR>',
        desc = '[T]rouble',
      },
    },
    opts = {},
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'Wansmer/treesj',
    cmd = 'TSJToggle',
    keys = {
      {
        '<leader>ts',
        mode = { 'n' },
        '<cmd>TSJToggle<CR>',
        desc = '[S]plit toggle',
      },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },

  {
    'okuuva/auto-save.nvim',
    cmd = 'ASToggle', -- optional for lazy loading on command
    event = { 'InsertLeave' }, -- optional for lazy loading on trigger events
    opts = {
      enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      execution_message = {
        enabled = false,
      },
      trigger_events = { -- See :h events
        immediate_save = { 'BufLeave', 'FocusLost' }, -- vim events that trigger an immediate save
        defer_save = {}, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_defered_save = { 'InsertEnter' }, -- vim events that cancel a pending deferred save
      },
      -- function that takes the buffer handle and determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      -- if set to `nil` then no specific condition is applied
      condition = nil,
      write_all_buffers = false, -- write all buffers when the current one meets `condition`
      noautocmd = false, -- do not execute autocmds when saving
      lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
      debounce_delay = 500, -- delay after which a pending save is executed
      -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
      debug = false,
    },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
}
