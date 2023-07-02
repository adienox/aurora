-- safe loading of nvimtree
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvimtree docs
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	-- copy default mappings here from defaults in next section
	vim.keymap.set("n", "L", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Up"))

	-- remove a default
	vim.keymap.del("n", "<C-]>", { buffer = bufnr })

	-- override a default
	vim.keymap.set("n", "<C-r>", api.tree.reload, opts("Refresh"))

	-- add your mappings
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

local options = {
	on_attach = my_on_attach,
	filters = {
		dotfiles = false,
		exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
		custom = { "^__pycache__$\\|^.mypy_cache$" },
	},
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		adaptive_size = false,
		side = "left",
		width = 30,
		preserve_window_proportions = true,
	},
	git = {
		enable = false,
		ignore = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		root_folder_label = false,
		highlight_git = false,
		highlight_opened_files = "none",

		indent_markers = {
			enable = false,
		},

		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},

			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
}

nvimtree.setup(options)
