local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- format & linting
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		opts = function()
			return require("custom.configs.null-ls")
		end,
	},

	-- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"NvChad/nvim-colorizer.lua",
		opts = overrides.colorizer,
	},

	-- Plugins
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		ft = { "markdown", "lua", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css" },
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"folke/twilight.nvim",
		event = "VeryLazy",
		ft = { "markdown", "lua", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css" },
		treesitter = true,
		dimming = {
			alpha = 0.25,
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		{
			"glepnir/lspsaga.nvim",
			opts = {
				lightbulb = { enable = false },
				symbol_in_winbar = { enable = false },
			},
			config = true,
		},
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
		event = "VeryLazy",
	},

	{
		"mbbill/undotree",
		event = "VeryLazy",
	},

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {},
		event = "VeryLazy",
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		event = "BufEnter",
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		event = "BufEnter",
	},

	{
		"tpope/vim-surround",
		event = "BufEnter",
	},

	{
		"windwp/nvim-ts-autotag",
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
	},
}

return plugins
