local M = {}

local actions = require("telescope.actions")
M.telescope = {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },

  extensions_list = { "ui-select", "howdoi" },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
    ["howdoi"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
}

M.treesitter = {
  auto_install = true,
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "markdown",
    "markdown_inline",
    "nix",
    "python",
    "bash",
    "regex",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.colorizer = {
  user_default_options = {
    RGB = true,    -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true,  -- "Name" codes like Blue or blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    AARRGGBB = true, -- 0xAARRGGBB hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true,    -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  },
}

M.mason = {
  ensure_installed = {
    -- everything installed using nix duh! (also cause regular binaries don't work with nixos)
  },
}

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "L", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "H", api.tree.change_root_to_parent, opts("Up"))

  vim.keymap.set("n", "<C-r>", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

  -- remove a default
  vim.keymap.del("n", "<C-]>", { buffer = bufnr })
end

M.nvimtree = {
  on_attach = my_on_attach,
  git = {
    enable = true,
    ignore = true,
  },
  filters = { custom = { "^.git$", "^.devenv$", "^.direnv$", "^venv$", "^.mypy_cache$" } },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.cmp = {
  mapping = {
    -- use Up and down for cycling completion
    ["<C-j>"] = require("cmp").mapping(function(fallback)
      local cmp = require("cmp")
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<C-k>"] = require("cmp").mapping(function(fallback)
      local cmp = require("cmp")
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
}

return M
