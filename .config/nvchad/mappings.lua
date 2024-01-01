---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<leader>fs"] = { ":w<CR>", "Write file" },
		["<leader>q"] = { ":q<CR>", "Quit" },

		-- Navigation
		["H"] = { "^", "Move to start of line", opts = { nowait = true } },
		["L"] = { "$", "Move to end of line", opts = { nowait = true } },

		-- utilities
		["x"] = { '"_x', "x without copy" },

		-- window
		["<leader>wv"] = { ":vsplit<CR>", "Vertical Split" },
		["<leader>ws"] = { ":split<CR>", "Horizontal Split" },
		["<leader>wc"] = { ":close<CR>", "Close current window" },

		-- apps
		["<leader>ou"] = { ":UndotreeToggle<CR>", "UndoTree" },

		-- git
		["<leader>gg"] = { ":Neogit<CR>", "Neogit" },
	},
	i = {
		["jk"] = { "<Esc>", "jk for Esc", opts = { nowait = true } },
	},
}

M.nvimtree = {
	n = {
		-- toggle
		["<leader>e"] = { ":NvimTreeToggle<CR>", "toggle nvimtree" },
	},
}

M.twilight = {
	n = {
		["<leader>tw"] = { ":Twilight<cr>", "toggle twilight" },
	},
}

M.trouble = {
	n = {
		["<leader>tt"] = { ":TroubleToggle<cr>", "toggle twilight" },
	},
}

return M
