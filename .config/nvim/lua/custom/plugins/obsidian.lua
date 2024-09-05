return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = {
    'ObsidianNew',
    'ObsidianDailies',
    'ObsidianToday',
    'ObsidianYesterday',
    'ObsidianTomorrow',
  },
  keys = {
    {
      '<leader>od',
      '<cmd>ObsidianToday<CR>',
      mode = 'n',
      desc = '[D]aily Note',
    },
    {
      '<leader>on',
      '<cmd>ObsidianNew<CR>',
      mode = 'n',
      desc = '[N]ew Note',
    },
    {
      '<leader>os',
      '<cmd>ObsidianQuickSwitch<CR>',
      mode = 'n',
      desc = '[S]earch Notes',
    },
  },
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/Zettles',
      },
    },

    daily_notes = {
      folder = 'Logs',
      date_format = '%Y/Daily/%m/%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      default_tags = { 'note/daily' },
      template = 'daily.md',
    },

    templates = {
      folder = 'Extras/Templates/nvim-templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },

    attachments = {
      img_folder = 'Extras/Media/imgs',
    },

    notes_subdir = 'Workbench',

    use_advanced_uri = true,
    open_app_foreground = true,

    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.date('%Y%m%d%H%M', os.time())) .. '-' .. suffix
    end,

    ---@param url string
    follow_url_func = function(url)
      vim.fn.jobstart { 'xdg-open', url } -- linux
    end,
  },
}
