return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'UiEnter',
  config = function()
    -- Eviline config for lualine
    -- Author: shadmansaleh
    -- Credit: glepnir
    local lualine = require 'lualine'
    local colors = require('catppuccin.palettes').get_palette 'mocha'

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {
          statusline = { 'veil', 'alpha' },
        },
        ignore_focus = { 'NvimTree' },
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      -- mode component
      function()
        return ''
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.mauve,
          no = colors.red,
          s = colors.peach,
          S = colors.peach,
          [''] = colors.peach,
          ic = colors.yellow,
          R = colors.lavender,
          Rv = colors.lavender,
          cv = colors.red,
          ce = colors.red,
          r = colors.sky,
          rm = colors.sky,
          ['r?'] = colors.sky,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }

    -- https://www.reddit.com/r/neovim/comments/xy0tu1/comment/irfegvd
    ins_left {
      function()
        local recording_register = vim.fn.reg_recording()
        if recording_register == '' then
          return ''
        else
          return ' @' .. recording_register
        end
      end,

      color = { fg = colors.red, gui = 'bold' },
    }

    -- Autocommands to ensure lualine is refreshed properly for showing macro recording
    vim.api.nvim_create_autocmd('RecordingEnter', {
      callback = function()
        lualine.refresh {
          place = { 'statusline' },
        }
      end,
    })

    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        lualine.refresh {
          place = { 'statusline' },
        }
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      callback = function()
        -- This is going to seem really weird!
        -- Instead of just calling refresh we need to wait a moment because of the nature of
        -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
        -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
        -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
        -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh {
              place = { 'statusline' },
            }
          end)
        )
      end,
    })

    ins_left {
      'filename',
      icons_enabled = true,
      cond = conditions.buffer_not_empty,
      color = { fg = colors.mauve, gui = 'bold' },
    }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.sky },
      },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return '%='
      end,
    }

    ins_left {
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' ',
      cond = function()
        return next(vim.lsp.get_clients()) ~= nil
      end,
      color = { fg = '#ffffff', gui = 'bold' },
    }

    -- Add components to right sections
    ins_right {
      'location',
      color = { fg = colors.fg, gui = 'bold' },
    }

    -- https://github.com/miversen33/miversen-dotfiles/blob/0c68c53cde78da453c056f021e839ae240c5bf7a/editors/nvim/lua/plugins/init.lua#L130-L308
    ins_right {
      function()
        local starts = vim.fn.line 'v'
        local ends = vim.fn.line '.'
        local count = starts <= ends and ends - starts + 1 or starts - ends + 1
        return count .. ' 󰈚 '
      end,
      cond = function()
        return vim.fn.mode():find '[Vv]' ~= nil
      end,
      color = { fg = colors.yellow, gui = 'bold' },
      padding = 0,
    }
    ins_right {
      function()
        local words = vim.fn.wordcount()['words']
        return words .. ' 󰯂 '
      end,
      cond = function()
        local ft = vim.opt_local.filetype:get()
        local count = {
          latex = true,
          tex = true,
          text = true,
          markdown = true,
          vimwiki = true,
        }
        return count[ft] ~= nil
      end,
      color = { fg = colors.mauve, gui = 'bold' },
      padding = 0,
    }

    ins_right {
      'fileformat',
      fmt = string.upper,
      icons_enabled = true,
      color = { fg = colors.peach, gui = 'bold' },
    }

    ins_right {
      'branch',
      icon = '',
      color = { fg = colors.lavender, gui = 'bold' },
    }

    ins_right {
      'diff',
      -- Is it me or the symbol for modified us really weird
      symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.peach },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}