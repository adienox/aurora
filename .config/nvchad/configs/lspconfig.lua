local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "tsserver", "nil_ls", "pyright", "bashls", "cssls", "emmet_ls", "lua_ls", "tailwindcss" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
