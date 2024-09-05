-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local set = vim.keymap.set

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quality of life
set({ 'n', 'v' }, 'H', '^')
set({ 'n', 'v' }, 'L', '$')
set({ 'n', 'v' }, 'j', 'gj')
set({ 'n', 'v' }, 'k', 'gk')
set({ 'n', 'i' }, '<C-n>', function()
  vim.fn.jobstart { 'tmux', 'switch-client', '-l' }
end)

set('n', '<leader>x', '<cmd>source %<CR>', { desc = 'E[X]ecute current file' })
set('n', '<leader>n', '<cmd>Noice dismiss<CR>', { desc = 'Dismiss [N]otifications' })

-- Diagnostic keymaps
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
