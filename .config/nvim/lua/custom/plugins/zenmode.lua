return {
  'folke/zen-mode.nvim',
  cmd = { 'ZenMode' },

  keys = {
    { '<leader>tz', '<cmd>ZenMode<CR>' },
  },
  opts = {
    window = {
      backdrop = 0.95,
      width = 0.7, -- width of the Zen window
      height = 0.9, -- height of the Zen window
      options = {
        signcolumn = 'no', -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = '0', -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      -- disable some global vim options (vim.o...)
      options = {
        enabled = true,
        ruler = true, -- disables the ruler text in the cmd line area
        showcmd = true, -- disables the command in the last line of the screen
        laststatus = 0, -- turn off the statusline in zen mode
      },
      twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
      gitsigns = { enabled = true }, -- disables git signs
      tmux = { enabled = true }, -- disables the tmux statusline

      kitty = {
        enabled = true,
        font = '+2', -- font size increment
      },
    },
    on_open = function(win)
      vim.cmd 'normal! zz'
    end,
  },
}
