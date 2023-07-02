-- safe loading of indent_blankline
local setup, blankline = pcall(require, "indent_blankline")
if not setup then
	return
end

local options = {
	filetype_exclude = {
		"help",
		"terminal",
		"lazy",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"alpha",
		"NvimTree",
	},
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = true,
	show_current_context = true,
	show_current_context_start = false,
}

blankline.setup(options)
