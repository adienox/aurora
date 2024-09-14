return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    {
      'tpope/vim-dadbod',
      lazy = true,
    },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql' },
      lazy = true,
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  keys = {
    {
      '<leader>td',
      mode = { 'n' },
      '<cmd>DBUIToggle<CR>',
      desc = '[D]adBod',
    },
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_use_nvim_notify = 1
  end,
}
