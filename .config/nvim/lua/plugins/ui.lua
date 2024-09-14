return {
  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        tailwind = true, -- enable tailwind support
        always_update = true, -- also apply to cmp and docs
      },
    },
    config = function(_, opts)
      require('colorizer').setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require('colorizer').attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    event = 'VeryLazy',
    opts = {
      theme = 'catppuccin',
    },
  },

  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
  },

  {
    'karb94/neoscroll.nvim',
    opts = {},
    event = 'VeryLazy',
  },

  {
    'folke/twilight.nvim',
    cmd = { 'Twilight' },
    keys = {
      {
        '<leader>tw',
        mode = { 'n' },
        '<cmd>Twilight<CR>',
        desc = 'T[W]ilight',
      },
    },
    opts = {
      context = 0,
      expand = {
        'function',
        'method',
        'table',
        'if_statement',
        -- markdown
        'paragraph',
        'fenced_code_block',
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
}
