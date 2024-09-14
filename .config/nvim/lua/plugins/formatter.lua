return { -- Autoformat
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, toml = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      nix = { 'alejandra' },
      python = { 'black' },
      javascript = { 'prettierd' },
      css = { 'prettierd' },
      sh = { 'shfmt' },
      go = { 'goimports-reviser', 'gofumpt', 'golines' },
    },
    formatters = {
      black = {
        prepend_args = { '--fast' },
      },
      ['goimports-reviser'] = { prepend_args = { '-rm-unused' } },
      golines = { prepend_args = { '--max-len=80' } },
      injected = { options = { ignore_errors = true, lang_to_ext = { go = 'go' } } },
    },
  },
}
