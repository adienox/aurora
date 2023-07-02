-- safe loading of cmp
local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
	return
end

-- safe loading of luasnip
local luasnip_setup, luasnip = pcall(require, "luasnip")
if not luasnip_setup then
	return
end

-- safe loading of lspkind
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load friendly snippets
require("luasnip/loaders/from_vscode").lazy_load()

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

local options = {
	completion = {
		completeopt = "menu,menuone",
	},
	window = {
		completion = {
			border = border("CmpBorder"),
			scrollbar = false,
			winhighlight = "Normal:CmpPmenu,Search:PmenuSel",
			side_padding = 0,
		},
		documentation = {
			border = border("CmpDocBorder"),
			winhighlight = "Normal:CmpDoc",
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
		{ name = "treesitter" },
		{ name = "spell" },
	}),

	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
}

-- cmp themeing
local cmp_theme = {
	icons = true,
	lspkind_text = true,
	style = "default", -- default/flat_light/flat_dark/atom/atom_colored
	border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
	selected_item_bg = "colored", -- colored / simple
}

cmp.setup(options)
