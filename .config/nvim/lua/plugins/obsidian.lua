return {
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
        '<leader>op',
        '<cmd>ObsidianPasteImg<CR>',
        mode = 'n',
        desc = '[P]aste Image',
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
      {
        '<leader>oc',
        '<cmd>ObsidianTemplate current<CR>',
        mode = 'n',
        desc = '[C]urrent Date & Time',
      },
    },
    opts = {
      -- ui = { enable = false },

      workspaces = {
        {
          name = 'personal',
          path = '~/Documents/Zettels',
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
        substitutions = {
          current = function()
            return os.date '%b %d, %Y %H:%M'
          end,
        },
      },

      attachments = {
        img_folder = 'Extras/Media/imgs',
      },

      notes_subdir = 'Cards',

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
        return suffix
      end,

      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        -- add new field 'created' if its not a daily note
        if note:get_field 'created' == nil and not string.find(note.path.filename, 'Logs') then
          note:add_field('created', os.date '%b %d, %Y %H:%M')
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      ---@param url string
      follow_url_func = function(url)
        vim.notify 'Opening in browser...'
        vim.fn.jobstart { 'xdg-open', url }
      end,
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = 'markdown',
    opts = {
      render_modes = { 'n', 'v', 'i', 'c' },
      heading = {
        position = 'inline',
      },
      bullet = {
        icons = { '•', '◦', '◆', '◇' },
        right_pad = 1,
      },
      link = { hyperlink = '' },
      code = { style = 'language', sign = false },
    },
  },
}
