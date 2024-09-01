return {
  'samharju/yeet.nvim',
  dependencies = {
    'stevearc/dressing.nvim', -- optional, provides sane UX
  },
  cmd = 'Yeet',
  opts = {
    interrupt_before_yeet = false,
    clear_before_yeet = true,
    notify_on_success = false,
  },
  keys = {
    {
      -- Douple tap \ to yeet at something
      '\\\\',
      function()
        require('yeet').execute()
      end,
    },
    {
      -- Pop command cache open
      '<leader>yc',
      function()
        require('yeet').list_cmd()
      end,
      desc = '[C]ommand to run',
    },
    {
      -- Open target selection
      '<leader>yt',
      function()
        require('yeet').select_target()
      end,
      desc = '[T]arget pane',
    },
    {
      -- Toggle autocommand for yeeting after write
      '<leader>yw',
      function()
        require('yeet').toggle_post_write()
      end,
      desc = 'Yeet on [W]rite',
    },
  },
}
