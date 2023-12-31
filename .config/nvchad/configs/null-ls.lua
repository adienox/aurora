local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local opts = {
	sources = {
		-- webdev stuff
		format.prettierd.with({
			filetypes = {
				"html",
				"markdown",
				"css",
				"astro",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"markdown.mdx",
			},
		}), -- so prettier works only on these filetypes

		-- Lua
		format.stylua,

		-- Nix
		format.nixfmt,

		-- Python
		format.black,
		lint.mypy,
		lint.ruff,

		-- Shell
		format.shfmt,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
}

return opts
