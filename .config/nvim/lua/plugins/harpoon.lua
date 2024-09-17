return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  commit = 'e76cb03',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  },
  keys = function()
    local harpoon = require 'harpoon'
    local keys = {
      {
        '<leader>ha',
        function()
          harpoon:list():add()
        end,
        desc = '[A]dd Mark',
      },
      {
        '<leader>hl',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = '[L]ist Marks',
      },
      {
        '<leader>hp',
        function()
          harpoon:list():prev()
        end,
        desc = '[P]revious Mark',
      },
      {
        '<leader>hn',
        function()
          harpoon:list():next()
        end,
        desc = '[N]ext Mark',
      },
      {
        '<C-h>',
        function()
          harpoon:list():select(1)
        end,
      },
      {
        '<C-j>',
        function()
          harpoon:list():select(2)
        end,
      },
      {
        '<C-k>',
        function()
          harpoon:list():select(3)
        end,
      },
      {
        '<C-l>',
        function()
          harpoon:list():select(4)
        end,
      },
    }
    return keys
  end,
}
