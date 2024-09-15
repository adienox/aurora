return {
  'nvim-tree/nvim-tree.lua',
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
  keys = {
    {
      '<leader>e',
      mode = { 'n' },
      function()
        local nvimTree = require 'nvim-tree.api'
        local currentBuf = vim.api.nvim_get_current_buf()
        local currentBufFt = vim.api.nvim_get_option_value('filetype', { buf = currentBuf })
        if currentBufFt == 'NvimTree' then
          nvimTree.tree.toggle()
        else
          nvimTree.tree.focus()
        end
      end,
      desc = 'File [E]xplorer',
    },
  },
  config = function()
    require('nvim-tree').setup {
      filters = {
        custom = {
          '^.git$',
          '^.devenv$',
          '^.direnv$',
          '^venv$',
          '^.mypy_cache$',
          '^.obsidian$',
          '^.stfolder$',
          '^lazy-lock.json$',
          '^flake.lock$',
        },
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        adaptive_size = false,
        side = 'left',
        width = 30,
        preserve_window_proportions = true,
      },
      git = {
        enable = true,
        ignore = true,
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        highlight_opened_files = 'none',

        indent_markers = {
          enable = true,
        },

        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },

          glyphs = {
            default = '󰈚',
            symlink = '',
            folder = {
              default = '',
              empty = '',
              empty_open = '',
              open = '',
              symlink = '',
              symlink_open = '',
              arrow_open = '',
              arrow_closed = '',
            },
            git = {
              unstaged = '✗',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '★',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'L', api.tree.change_root_to_node, opts 'CD')
        vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
        vim.keymap.set('n', 'H', api.tree.change_root_to_parent, opts 'Up')

        vim.keymap.set('n', '<C-r>', api.tree.reload, opts 'Refresh')
        vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')

        -- remove a default
        vim.keymap.del('n', '<C-]>', { buffer = bufnr })
      end,
    }
  end,
}
