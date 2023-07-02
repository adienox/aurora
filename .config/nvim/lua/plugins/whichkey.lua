-- safe loading of whichkey
local setup, whichkey = pcall(require, "which-key")
if not setup then
	return
end

-- Adding keybindings and their descriptions
local bindings = {
	["<leader>"] = {
		-- general keybindings
		w = { ":w<CR>", "Write file" },
		q = { ":q<CR>", "Quit" },
		e = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },
		u = { ":UndotreeToggle<CR>", "Toggle UndoTree" },
		h = { "<cmd>Telescope help_tags<cr>", "Search help" },
		nh = { ":nohl<CR>", "Clear search highlights" },
		-- Packer keybindings
		p = {
			name = "+packer",
			i = { ":PackerSync<CR>", "Run PackerSync" },
		},
		-- Buffer action keybindings
		b = {
			name = "+buffer",
			b = { "<cmd>Telescope buffers<cr>", "Search for buffers" },
			d = { "<cmd>bd<cr>", "Close current buffer" },
		},
		-- File action keybindings
		f = {
			name = "+file",
			c = { "<cmd>Telescope grep_string<cr>", "Search for string" },
			f = { "<cmd>Telescope find_files<cr>", "Find file" },
			n = { "<cmd>enew<cr>", "New file" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open recent file" },
			s = { "<cmd>Telescope live_grep<cr>", "Search using grep" },
		},
		-- Window Split keybindings
		s = {
			name = "+window split",
			v = { "<C-w>v", "Vertical split" },
			h = { "<C-w>s", "Horizontal split" },
			e = { "<C-w>=", "Make equal width" },
			x = { ":close", "Close current split" },
			m = { ":MaximizerToggle<CR>", "Maximize current split" },
			o = { ":so<CR>", "Source current file" },
		},
		-- Tab keybindings
		t = {
			name = "+tab & term",
			o = { ":tabnew<CR>", "Open new tab" },
			x = { ":tabclose<CR>", "Close current tab" },
			p = { ":tabp<CR>", "Switch to prev tab" },
			n = { ":tabn<CR>", "Switch to next tab" },
			t = { ":ToggleTerm<CR>", "Toggle Terminal" },
			v = { ":ToggleTerm size=60 direction=vertical<CR>", "Toggle Vertical Terminal" },
			h = { ":ToggleTerm direction=horizontal<CR>", "Toggle Horizontal Terminal" },
			f = { ":ToggleTerm direction=floating<CR>", "Toggle Floating Terminal" },
		},
	},
}

whichkey.setup()

whichkey.register(bindings)
