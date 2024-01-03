---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		[":"] = { ":!", "enter filter mode", opts = { nowait = true } },
		["<leader>fs"] = { "<cmd> w <cr>", "Write file" },
		["<leader>q"] = { "<cmd> q <cr>", "Quit" },

		-- Navigation
		["H"] = { "^", "Move to start of line", opts = { nowait = true } },
		["L"] = { "$", "Move to end of line", opts = { nowait = true } },

		-- utilities
		["x"] = { '"_x', "x without copy" },

		-- window
		["<leader>wv"] = { "<cmd> vsplit <cr>", "Vertical Split" },
		["<leader>ws"] = { "<cmd> split <cr>", "Horizontal Split" },
		["<leader>wc"] = { "<cmd> close <cr>", "Close current window" },

		-- apps
		["<leader>ou"] = { "<cmd> UndotreeToggle <cr>", "UndoTree" },

		-- git
		["<leader>gg"] = { "<cmd> Neogit <cr>", "Neogit" },

		-- hop
		["f"] = { "<cmd> HopWord <cr>", "Hop to a word" },
	},
	i = {
		["jk"] = { "<Esc>", "jk for Esc", opts = { nowait = true } },
	},
}

M.nvimtree = {
	n = {
		["<leader>e"] = { "<cmd> NvimTreeToggle <cr>", "toggle nvimtree" },
	},
}

M.twilight = {
	n = {
		["<leader>tw"] = { "<cmd> Twilight <cr>", "toggle twilight" },
	},
}

M.telescope = {
	n = {
		["<leader>ft"] = { "<cmd> TodoTelescope <cr>", "Todo Telescope" },
		["<leader>fn"] = { "<cmd> Telescope notify <cr>", "Notification List" },
	},
}

M.trouble = {
	n = {
		["<leader>tt"] = { "<cmd> TroubleToggle <cr>", "toggle twilight" },
	},
}

return M
