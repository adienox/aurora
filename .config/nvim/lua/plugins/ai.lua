return {
  {
    'jackMort/ChatGPT.nvim',
    cmd = { 'ChatGPTRun' },
    keys = {
      {
        '<leader>aa',
        mode = { 'n', 'v' },
        '<cmd>ChatGPTRun add_tests<CR>',
        desc = '[A]dd Tests',
      },
      {
        '<leader>ac',
        mode = { 'n' },
        '<cmd>ChatGPT<CR>',
        desc = '[C]hat',
      },
      {
        '<leader>ad',
        mode = { 'n', 'v' },
        '<cmd>ChatGPTRun docstring<CR>',
        desc = '[D]ocstring',
      },
      {
        '<leader>as',
        mode = { 'n', 'v' },
        '<cmd>ChatGPTRun summarize<CR>',
        desc = '[S]ummarize',
      },
      {
        '<leader>ax',
        mode = { 'n', 'v' },
        '<cmd>ChatGPTRun explain_code<CR>',
        desc = 'E[X]plain Code',
      },
      {
        '<leader>ae',
        mode = { 'n', 'v' },
        '<cmd>ChatGPTEditWithInstruction<CR>',
        desc = '[E]dit with instruction',
      },
    },
    config = function()
      require('chatgpt').setup {
        api_key_cmd = 'openaigptkey.sh',
      }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  -- {
  --   'olimorris/codecompanion.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
  --     {
  --       'stevearc/dressing.nvim', -- Optional: Improves the default Neovim UI
  --       opts = {},
  --     },
  --     'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
  --   },
  --   config = true,
  -- },
}
