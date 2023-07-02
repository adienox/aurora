vim.g.mapleader = " "

local keymap = vim.keymap -- for consiseness

-- General Keymaps
keymap.set("i", "jk", "<Esc>") -- jk for <Esc>
keymap.set("t", "jk", "<C-\\><C-n>") -- jk for <Esc> in terminal
keymap.set("n", "H", "^") -- H for moving to the start of the line
keymap.set("n", "L", "$") -- L for moving to the end of the line
keymap.set("n", "x", '"_x') -- Delete character using x but not copy to clipboard
keymap.set("n", "<leader>nh", ":nohl<CR>") -- Clear Search Highlights

-- Moving code block using J and K
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<Tab>", "za<CR>")

-- File Action Keymaps
keymap.set("n", "<leader>w", ":w<CR>") -- Write file using <leader> w
keymap.set("n", "<leader>q", ":q<CR>") -- Quit using <leader> q

-- Utility Keymaps
keymap.set("n", "<leader>pi", vim.cmd.PackerSync) -- Run packer Sync
keymap.set("n", "<leader>so", vim.cmd.so) -- Source the current file

-- Window-Slip Keymaps
keymap.set("n", "<leader>sv", "<C-w>v") -- Vertical plit
keymap.set("n", "<leader>sh", "<C-w>s") -- Horizontal split
keymap.set("n", "<leader>se", "<C-w>=") -- Make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- Close current split window
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- Toggle current window maximizer

-- Tab Keybindings
keymap.set("n", "<leader>to", ":tabnew<CR>") -- Open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- Close current tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- Go to previous tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- Go to next tab

-- Plugin Keybindings

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- Show the file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- terminal
keymap.set("n", "<leader>tt", ":ToggleTerm<CR>")

-- undo tree
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
