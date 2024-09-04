local opt = vim.opt_local

opt.conceallevel = 2
opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
opt.expandtab = false
opt.tabstop = 4

vim.keymap.set({ 'n', 'i' }, '<leader>od', '<cmd>ObsidianToday<CR>')
vim.keymap.set({ 'n', 'i' }, '<leader>on', '<cmd>ObsidianNew<CR>')
