-- safe loading of treesitter
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
local options = {
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable rainbow parens
	rainbow = {
		enable = true,
		-- list of languages you want to disable the plugin for
		-- disable = { "jsx", "cpp" },
		-- Which query to use for finding delimiters
		query = "rainbow-parens",
		-- Highlight the entire buffer all at once
		strategy = require("ts-rainbow").strategy.global,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
		"javascript",
		"typescript",
		"tsx",
		"regex",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"python",
	},
	-- auto install above language parsers
	auto_install = true,
}
treesitter.setup(options)
