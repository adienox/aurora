local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = require("custom.configs.noice"),
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				opts = {
					background_colour = "#000000",
					render = "compact",
				},
			},
		},
	},

	{
		"phaazon/hop.nvim",
		event = "BufEnter",
		opts = {},
	},

	{
		"RRethy/vim-illuminate",
		event = "BufEnter",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				min_count_to_highlight = 2,
			})
		end,
	},

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

	{
		"nvim-telescope/telescope.nvim",
		opts = overrides.telescope,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = overrides.cmp,
	},

	-- Plugins
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		opts = {},
	},

	{
		"kylechui/nvim-surround",
		event = "BufEnter",
		ft = { "markdown", "lua", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css" },
		opts = {},
	},

	{
		"folke/twilight.nvim",
		event = "BufEnter",
		ft = { "markdown", "lua", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css" },
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

	-- git blame
	{
		"f-person/git-blame.nvim",
		event = "BufEnter",
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
		event = "BufEnter",
	},

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		event = "BufEnter",
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "BufEnter",
		opts = {},
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "BufEnter",
		opts = {},
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
