require("core")
require("plugins")

-- Auto-Install packer if not already installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

-- Auto Command to reload neovim whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Colorscheme
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Show colors
	use("norcalli/nvim-colorizer.lua")

	-- CursorLineNr highlight
	use({
		"mawkler/modicator.nvim",
		after = "catppuccin/nvim",
		config = function()
			require("modicator").setup()
		end,
	})

	-- Tmux & Split window navigation
	use("christoomey/vim-tmux-navigator")

	-- Maximizes and restores current window split
	use("szw/vim-maximizer")

	-- Easy keybindings for CRUD on surrounding elements
	use("tpope/vim-surround")

	use("vim-scripts/ReplaceWithRegister")

	-- Easier commenting
	use("numToStr/Comment.nvim")

	-- indentation highlight
	use("lukas-reineke/indent-blankline.nvim")

	-- matching word illumination
	use("RRethy/vim-illuminate")

	-- undotree
	use("mbbill/undotree")

	-- Better menu
	use("stevearc/dressing.nvim")

	-- Notifications
	use("rcarriga/nvim-notify")

	-- Modern File Explorer
	use({ "nvim-tree/nvim-tree.lua", requires = {
		"nvim-tree/nvim-web-devicons",
	} })

	-- multi cursor
	use("mg979/vim-visual-multi")

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- which key
	use("folke/which-key.nvim")
	use({ "akinsho/toggleterm.nvim", tag = "*" })

	-- show code context
	use("nvim-treesitter/nvim-treesitter-context")

	-- rainbow parens
	use("HiPhish/nvim-ts-rainbow2")

	-- pretty list of code mishaps and trouble
	use({ "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } })

	-- Pretty folding
	use({
		"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end,
	})

	-- Better ui for everything
	use({ "folke/noice.nvim", requires = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	} })

	-- God damn pretty marks
	use("kshenoy/vim-signature")

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			{ "nvim-tree/nvim-web-devicons", opt = true },
		},
	})

	-- Dashboard
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})

	-- Fuzzyfinder
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer", -- buffer completion
			"hrsh7th/cmp-path", -- path completion
			"ray-x/cmp-treesitter", -- integration with treesitter
			"f3fora/cmp-spell", -- spelling completion
			"hrsh7th/cmp-nvim-lsp", -- integration with lsp
			"onsails/lspkind.nvim", -- vscode like symbol glyphs
		},
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"rafamadriz/friendly-snippets", -- additional vscode like snippets
			"saadparwaiz1/cmp_luasnip", -- integration with cmp
		},
	})

	-- managing & installing lsp servers, linters & formatters
	use({ "williamboman/mason-lspconfig.nvim", requires = {
		"williamboman/mason.nvim",
	} })

	-- configuring lsp servers
	use("neovim/nvim-lspconfig")

	-- Enhanced lsp
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			"nvim-tree/nvim-web-devicons",
			--Please make sure you install markdown and markdown_inline parser
			"nvim-treesitter/nvim-treesitter",
		},
	})

	-- formatting & linting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"jayp0521/mason-null-ls.nvim", -- integration with mason
		},
	})

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
