-- safe loading of lualine
local line_setup, lualine = pcall(require, "lualine")
if not line_setup then
	return
end

-- safe loading of noice
local noice_setup, noice = pcall(require, "noice")
if not noice_setup then
	return
end

local options = {
	options = {
		theme = "catppuccin",
	},
	sections = {
		lualine_a = { { "mode", icons_enabled = true, icon = "" } },
		lualine_b = { "filename" },
		lualine_c = { "branch", "diff", "diagnostics" },
		lualine_x = {
			{
				noice.api.status.command.get,
				cond = noice.api.status.command.has,
				color = { fg = "#ff9e64" },
			},
		},
		lualine_y = { "filetype" },
		lualine_z = { { "progress", icons_enabled = true, icon = "" } },
	},
	extentions = {
		"toggleterm",
		"nvim-tree",
	},
}

lualine.setup(options)
