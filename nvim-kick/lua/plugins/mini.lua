return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.icons').setup()
      local ai = require 'mini.ai'
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
          e = { -- Word with case
            { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
            '^().*()$',
          },
        },
      }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup()
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      statusline.section_filename = function()
        return '%f%m%r'
      end

      local hi = require 'mini.hipatterns'
      hi.setup {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
          shorthand = {
            pattern = '()#%x%x%x()%f[^%x%w]',
            group = function(_, _, data)
              ---@type string
              local match = data.full_match
              local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
              local hex_color = '#' .. r .. r .. g .. g .. b .. b

              return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
            end,
            extmark_opts = { priority = 2000 },
          },
          fixme = { pattern = 'FIXME:', group = 'MiniHipatternsFixme' },
          hack = { pattern = 'HACK:', group = 'MiniHipatternsHack' },
          todo = { pattern = 'TODO:', group = 'MiniHipatternsTodo' },
          note = { pattern = 'NOTE:', group = 'MiniHipatternsNote' },
        },
      }

      -- Alter pairings so they do not insert the pair near alphanumeric characters
      -- https://github.com/nvim-mini/mini.nvim/issues/835#issue-2259647068
      local pairs_mappings = {
        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%w\\][^%w\\]', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%w\\][^%w\\]', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%w\\][^%w\\]', register = { cr = false } },
      }
      require('mini.pairs').setup { mappings = pairs_mappings }

      require('mini.tabline').setup {
        format = function(buf_id, label)
          local suffix = vim.bo[buf_id].modified and '+ ' or ''
          return MiniTabline.default_format(buf_id, label) .. suffix
        end,
      }

      require('mini.basics').setup {
        options = {
          extra_ui = true,
        },
        mappings = {
          option_toggle_prefix = '<leader>t',
        },
      }

      local starter = require 'mini.starter'
      local header = function()
        local hour = tonumber(vim.fn.strftime '%H')
        -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
        local part_id = math.floor((hour + 4) / 8) + 1
        local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
        local username = vim.loop.os_get_passwd()['username'] or 'USERNAME'
        local cwd = vim.fn.getcwd()

        return ('Good %s, %s\ncwd: %s'):format(day_part, username, cwd)
      end
      starter.setup {
        evaluate_single = true,
        items = {
          { name = 'Find files', action = 'lua require("fzf-lua").files()', section = 'Picker' },
          { name = 'Grep files', action = 'lua require("fzf-lua").live_grep()', section = 'Picker' },
          { name = 'Explore files', action = 'lua require("mini.files").open()', section = 'Picker' },
          starter.sections.recent_files(10, true),
          starter.sections.builtin_actions(),
        },
        header = header(),
      }

      require('mini.bufremove').setup()

      require('mini.indentscope').setup()

      require('mini.bracketed').setup {
        conflict = { suffix = 'n' },
        diagnostic = { options = { float = false } },
        comment = { suffix = '' },
        file = { suffix = '' },
      }

      require('mini.files').setup()
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local cur_target = MiniFiles.get_explorer_state().target_window
          local new_target = vim.api.nvim_win_call(cur_target, function()
            vim.cmd(direction .. ' split')
            return vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target)
          MiniFiles.go_in { close_on_file = true }
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          map_split(buf_id, '<C-s>', 'belowright horizontal')
          map_split(buf_id, '<C-v>', 'belowright vertical')
          map_split(buf_id, '<C-t>', 'tab')
        end,
      })

      vim.keymap.set('n', '<leader>fe', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      end, { desc = 'Explore parent directory' })
      vim.keymap.set('n', '<leader>fE', function()
        MiniFiles.open(nil, false)
      end, { desc = 'Explore current working directory' })

      require('mini.visits').setup()
      local map_vis = function(keys, call, desc)
        local rhs = '<Cmd>lua MiniVisits.' .. call .. '<CR>'
        vim.keymap.set('n', '<Leader>' .. keys, rhs, { desc = desc })
      end

      map_vis('va', 'add_label("core")', 'Add to core')
      map_vis('vd', 'remove_label("core")', 'Remove from core')
      map_vis('vs', 'select_path(nil, { filter = "core" })', 'Select from core')
      map_vis('vl', 'select_path(nil,nil)', 'Select from all paths')
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
