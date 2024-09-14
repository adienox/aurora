-- most of the config goodies are from https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/theta.lua

local if_nil = vim.F.if_nil
local leader = 'SPC'

local function truncateString(str, limit)
  -- Check if the input string is longer than the limit
  if #str > limit then
    -- Truncate the string and append ellipsis
    return str:sub(1, limit - 3) .. '...'
  else
    -- Return the string as is if it's within the limit
    return str
  end
end

local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub('%s', ''):gsub(leader, '<leader>')

  local opts = {
    position = 'center',
    shortcut = sc,
    cursor = 3,
    width = 50,
    align_shortcut = 'right',
    hl = 'AlphaButtons',
    hl_shortcut = 'AlphaShortcut',
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, 't', false)
  end

  return {
    type = 'button',
    val = truncateString(txt, 45),
    on_press = on_press,
    opts = opts,
  }
end

local function file_button(fn, sc, short_fn)
  local fb_hl = {}
  local ico_txt = ''
  local cd_cmd = ' | cd %:p:h'

  local file_button_el = button(sc, short_fn, '<cmd>e ' .. vim.fn.fnameescape(fn) .. cd_cmd .. ' <CR>')

  local fn_start = short_fn:match '.*[/\\]'
  if fn_start ~= nil then
    table.insert(fb_hl, { 'Comment', #ico_txt - 2, #fn_start + #ico_txt })
  end

  file_button_el.opts.hl = fb_hl
  return file_button_el
end

local function recents(cwd)
  local items_number = 5

  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #oldfiles == items_number then
      break
    end
    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end
    local ignore = false
    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
      oldfiles[#oldfiles + 1] = v
    end
  end

  local tbl = {}
  for i, fn in ipairs(oldfiles) do
    local short_fn = fn
    if cwd then
      short_fn = vim.fn.fnamemodify(fn, ':.')
    else
      short_fn = vim.fn.fnamemodify(fn, ':~')
    end

    local shortcut = tostring(i)

    local file_button_el = file_button(fn, shortcut, short_fn)
    tbl[i] = file_button_el
  end

  return {
    type = 'group',
    val = tbl,
    opts = {},
  }
end

return {
  'goolord/alpha-nvim',
  config = function()
    local elements = {
      header = {},
      buttons = {},
      recents = {},
      footer = {},
    }

    elements.header = {
      type = 'text',
      val = {
        '           ▄ ▄                   ',
        '       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ',
        '       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ',
        '    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ',
        '  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ',
        '  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄',
        '▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █',
        '█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █',
        '    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ',
      },
      opts = {
        position = 'center',
        hl = 'AlphaHeaderLabel',
      },
    }

    elements.buttons = {
      type = 'group',
      val = {
        button('nn', '  New File', '<cmd>enew<CR>'),
        button('sf', '  Find File', '<cmd>Telescope find_files<CR>'),
        button('gs', '󰊢  Git Status', '<cmd>Telescope git_status<CR>'),
        button('rf', '  Recently Used Files', '<cmd>Telescope oldfiles<CR>'),
        button('sg', '󰭷  Find Word', '<cmd>Telescope live_grep<CR>'),
        button('sm', '󰸕  Jump to Mark', '<cmd>Telescope marks<CR>'),
        button('qq', '󰅚  Quit', '<cmd>wincmd q<CR>'),
      },
      opts = {
        spacing = 1,
      },
    }

    elements.recents = {
      type = 'group',
      val = function()
        return { recents(vim.fn.getcwd()) }
      end,
      opts = { shrink_margin = false },
    }

    local config = {
      layout = {
        { type = 'padding', val = 5 },
        elements.header,
        { type = 'padding', val = 5 },
        elements.buttons,
        { type = 'padding', val = 2 },
        elements.recents,
      },
      opts = {
        margin = 5,
      },
    }

    require('alpha').setup(config)
  end,
}
