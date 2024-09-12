return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- Using both in conjunction looks nice.
      {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        commit = '29be0919b91fb59eca9e90690d76014233392bef',
      },
    },
    config = function()
      -- Better Around/Inside textobjects
      --
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Indent lines using both indent-blankline and mini.indentscope
      require('ibl').setup {
        indent = {
          char = '▏',
        },
        scope = { enabled = false },
      }

      require('mini.indentscope').setup {
        draw = {
          delay = 40,
          priority = 20,
          animation = require('mini.indentscope').gen_animation.linear {
            easing = 'in',
            duration = 40,
            unit = 'step',
          },
        },
        symbol = '▏',
        options = {
          try_as_border = true,
        },
        mappings = {
          goto_top = '',
          goto_bottom = '',
          object_scope = '',
          object_scope_with_border = '',
        },
      }
    end,
  },
}
