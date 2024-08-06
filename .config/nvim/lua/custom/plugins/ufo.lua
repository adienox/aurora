return {
  'kevinhwang91/nvim-ufo',
  event = 'LspAttach',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    local ufo = require 'ufo'
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open All Folds' })
    vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close All Folds' })
    vim.keymap.set('n', 'zK', function()
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek Fold' })
    ufo.setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'lsp', 'indent' }
      end,
    }
  end,
}
