vim.opt_local.conceallevel = 2

local opts = {
  dir = "~/Documents/Knowledge-Garden",
  notes_subdir = "Cards",

  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "Cards/Temporal/Daily",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y-%m-%d",
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = "Temporal/Daily.md",
  },

  templates = {
    subdir = "Extras/Templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },

  attachments = {
    img_folder = "Extras/Media",
  },

  follow_url_func = function(url)
    vim.fn.jobstart({ "xdg-open", url }) -- linux
  end,
}

return opts
