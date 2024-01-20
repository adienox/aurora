local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    f = { name = "+file & list" },
    c = { name = "+code" },
    g = { name = "+git & lsp" },
    l = { name = "+lsp & flash" },
    m = { name = "+marks" },
    o = { name = "+applications" },
    t = { name = "+toggles" },
    w = { name = "+workspace & windows" },
  },
})
