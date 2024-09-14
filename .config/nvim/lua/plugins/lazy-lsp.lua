return {
  'dundalek/lazy-lsp.nvim',
  config = function()
    -- enabling snippet support for css
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require('lazy-lsp').setup {
      excluded_servers = {
        'ccls', -- prefer clangd
        'denols', -- prefer eslint and tsserver
        'docker_compose_language_service', -- yamlls should be enough?
        'flow', -- prefer eslint and tsserver
        'ltex', -- grammar tool using too much CPU
        'quick_lint_js', -- prefer eslint and tsserver
        'rnix', -- archived on Jan 25, 2024
        'scry', -- archived on Jun 1, 2023
        'nixd', -- using nil_ls
        'drools_lsp', -- causing startup issues
        'mutt_ls', -- causing startup issues
        'als', -- causing startup issues
        'bazelrc-lsp', -- causing startup issues
        'tsserver', -- renamed to ts_ls
      },
      experimental_lazy_setup = true,
      prefer_local = true, -- Prefer locally installed servers over nix-shell
      preferred_servers = {
        markdown = {},
        python = { 'pyright', 'ruff_lsp' },
        css = { 'cssls' },
      },
      default_config = {
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = capabilities,
      },
      configs = {
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
              hint = { enable = true },
            },
          },
        },
      },
    }
  end,
}
