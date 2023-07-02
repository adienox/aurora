local opt = vim.opt --for consiseness

-- enable auto write file on buffer change
vim.o.autowriteall = true

-- Shows signs by Autocompletion plugin
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone"

vim.o.cursorline = true

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line Wrapping
opt.wrap = false

-- Search Settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Swap & Undo
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.cache/undodir"
opt.undofile = true

-- Appearance
opt.termguicolors = true
opt.list = true
opt.background = "dark"
opt.signcolumn = "yes"
vim.wo.fillchars = "eob: "

-- Scroll View
opt.scrolloff = 8
opt.updatetime = 50

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Window Splitting
opt.splitright = false
opt.splitbelow = true

-- Time in milliseconds to wait for a mapped sequence to complete.
opt.timeoutlen = 300

-- Misc
opt.iskeyword:append("-")

-- Save and load view/fold
-- vim.cmd([[
--   augroup SaveLoadView
--     au BufWinLeave *.* mkview
--     au BufWinEnter *.* silent loadview
--   augroup end
-- ]])

-- toggle tmux status with vim
-- vim.cmd([[
--   augroup TmuxStatus
--     au VimEnter * silent !tmux set status off
--     au VimLeave * silent !tmux set status on
--   augroup end
-- ]])
-- TODO fix exit delay
