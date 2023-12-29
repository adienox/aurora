local M = {}

-- recommended settings from nvimtree docs
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "L", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Up"))

	vim.keymap.set("n", "<C-r>", api.tree.reload, opts("Refresh"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

	-- remove a default
	vim.keymap.del("n", "<C-]>", { buffer = bufnr })
end

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"markdown",
		"markdown_inline",
		"nix",
		"python",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.colorizer = {
	user_default_options = {
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		names = true, -- "Name" codes like Blue or blue
		RRGGBBAA = true, -- #RRGGBBAA hex codes
		AARRGGBB = true, -- 0xAARRGGBB hex codes
		rgb_fn = true, -- CSS rgb() and rgba() functions
		hsl_fn = true, -- CSS hsl() and hsla() functions
		css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
	},
}

M.mason = {
	ensure_installed = {
		-- everything installed using nix duh! (also cause regular binaries don't work with nixos)
		-- -- web dev stuff
		-- "css-lsp",
		-- "html-lsp",
		-- "eslint-lsp",
		-- "tailwindcss-language-server",
		-- "prettierd",
		--
		-- -- python stuff
		-- "pyright",
	},
}

M.nvimtree = {
	on_attach = my_on_attach,
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

M.cmp = {
	sources = {
		name = "nvim_lsp",
		priority = 10,
		keyword_length = 6,
		group_index = 1,
		max_item_count = 15,
	},
}

return M
