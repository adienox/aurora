local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
  -- format & linting
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require("custom.configs.null-ls")
    end,
  },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = overrides.colorizer,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  {
    "folke/which-key.nvim",
    config = function(_, opts)
      require("which-key").setup(opts)
      require("custom.configs.which-key")
    end,
    setup = function()
      require("core.utils").load_mappings("whichkey")
    end,
  },

  -- Plugins
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require("custom.configs.noice"),
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          dofile(vim.g.base46_cache .. "notify")
          require("notify").setup({
            background_colour = "#000000",
            render = "compact",
          })
        end,
      },
    },
  },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("custom.configs.chat-gpt")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "folke/flash.nvim",
    event = "BufEnter",
    opts = {},
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    event = "BufEnter",
    ft = { "markdown", "lua", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css" },
    opts = {},
  },

  {
    "folke/twilight.nvim",
    event = "BufEnter",
    ft = { "markdown", "lua", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css" },
  },

  {
    "lewis6991/gitsigns.nvim",
    {
      "glepnir/lspsaga.nvim",
      opts = {
        lightbulb = { enable = false },
        symbol_in_winbar = { enable = false },
      },
      config = true,
    },
  },

  -- git blame
  {
    "f-person/git-blame.nvim",
    event = "BufEnter",
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",      -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",     -- optional
      "ibhagwan/fzf-lua",           -- optional
    },
    config = true,
    event = "VeryLazy",
  },

  {
    "mbbill/undotree",
    event = "BufEnter",
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    event = "BufEnter",
    opts = {
      theme = "catppuccin",
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufEnter",
    config = function()
      dofile(vim.g.base46_cache .. "todo")
      require("todo-comments").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "TroubleToggle",
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup()
    end,
  },

  {
    "phaazon/hop.nvim",
    event = "BufEnter",
    config = function()
      dofile(vim.g.base46_cache .. "hop")
      require("hop").setup()
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufEnter",
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = "BufEnter",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
          "NvimTree",
          "NeogitStatus",
        },
        min_count_to_highlight = 2,
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
}

return plugins
