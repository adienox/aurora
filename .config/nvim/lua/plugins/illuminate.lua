-- safe loading of illuminate
local setup, illuminate = pcall(require, "illuminate")
if not setup then
	return
end

local options = {
	providers = {
		"lsp",
		"treesitter",
		"regex",
	},
	min_count_to_highlight = 2,
}

illuminate.configure(options)

vim.cmd("hi def IlluminatedWordText gui=underline")
