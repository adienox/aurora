local setup, catppuccin = pcall(require, "catppuccin")
if not setup then
	print("Colorscheme not found!")
	return
end

local options = {
	integrations = {
		cmp = true,
	},
	highlight_overrides = {
		all = function(colors)
			return {
				NvimTreeNormal = { bg = colors.none },
				CmpBorder = { fg = colors.blue },
				CmpItemAbbrMatch = { fg = colors.lavender, style = { "bold" } },
			}
		end,
	},
}

catppuccin.setup(options)

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
