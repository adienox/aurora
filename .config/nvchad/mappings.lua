---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<leader>cm"] = "",
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    [":"] = { ":!", "enter filter mode", opts = { nowait = true } },
    ["<leader>fs"] = { "<cmd> w <cr>", "Write file" },
    ["<leader>q"] = { "<cmd> q <cr>", "Quit" },

    -- Navigation
    ["H"] = { "^", "Move to start of line", opts = { nowait = true } },
    ["L"] = { "$", "Move to end of line", opts = { nowait = true } },

    -- utilities
    ["x"] = { '"_x', "x without copy" },
    ["f"] = { "<cmd> HopWord <cr>", "Hop to a word" },
    ["<leader>n"] = { "<cmd> NoiceDismiss <cr>", "Dismiss Notifications" },

    -- window
    ["<leader>wv"] = { "<cmd> vsplit <cr>", "Vertical Split" },
    ["<leader>ws"] = { "<cmd> split <cr>", "Horizontal Split" },
    ["<leader>wc"] = { "<cmd> close <cr>", "Close current window" },

    -- apps
    ["<leader>ou"] = { "<cmd> UndotreeToggle <cr>", "UndoTree" },

    -- git
    ["<leader>gg"] = { "<cmd> LazyGit <cr>", "Open LazyGit TUI" },
  },
  i = {
    ["jk"] = { "<Esc>", "jk for Esc", opts = { nowait = true } },
  },
  v = {
    ["H"] = { "^", "Select to start of line", opts = { nowait = true } },
    ["L"] = { "$", "Select to end of line", opts = { nowait = true } },
  },
}

M.flash = {
  n = {
    ["<leader>lf"] = {
      function()
        require("flash").jump()
      end,
      "Flash Jump",
    },
    ["<leader>lt"] = {
      function()
        require("flash").treesitter()
      end,
      "Flash Treesitter",
    },
    ["<leader>lr"] = {
      function()
        require("flash").treesitter_search()
      end,
      "Flash Treesitter Search",
    },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <cr>", "toggle nvimtree" },
  },
}

M.twilight = {
  n = {
    ["<leader>tw"] = { "<cmd> Twilight <cr>", "toggle twilight" },
  },
}

M.telescope = {
  n = {
    ["<leader>ft"] = { "<cmd> TodoTelescope <cr>", "Todo Telescope" },
    ["<leader>fn"] = { "<cmd> Telescope notify <cr>", "Notification List" },
  },
}

M.trouble = {
  n = {
    ["<leader>tt"] = { "<cmd> TroubleToggle <cr>", "toggle trouble" },
  },
}

return M
