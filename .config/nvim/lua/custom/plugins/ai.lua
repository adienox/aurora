return {
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
    -- local wk = require 'which-key'
    -- wk.register({
    --   f = { '<cmd>ChatGPTRun fix_bugs<CR>', '[F]ix Bugs', mode = { 'n', 'v' } },
    --   g = { '<cmd>ChatGPTRun grammar_correction<CR>', '[G]rammar Correction', mode = { 'n', 'v' } },
    --   k = { '<cmd>ChatGPTRun keywords<CR>', '[K]eywords', mode = { 'n', 'v' } },
    --   l = { '<cmd>ChatGPTRun code_readability_analysis<CR>', 'Code Readability Analysis', mode = { 'n', 'v' } },
    --   o = { '<cmd>ChatGPTRun optimize_code<CR>', '[O]ptimize Code', mode = { 'n', 'v' } },
    --   r = { '<cmd>ChatGPTRun roxygen_edit<CR>', '[R]oxygen Edit', mode = { 'n', 'v' } },
    --   t = { '<cmd>ChatGPTRun translate<CR>', '[T]ranslate', mode = { 'n', 'v' } },
    -- }, { prefix = '<leader>a' })
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
