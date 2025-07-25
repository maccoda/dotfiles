return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
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

      require('mini.pairs').setup()

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
      starter.setup {
        evaluate_single = true,
        items = {
          { name = 'Find files', action = 'lua require("fzf-lua").files()', section = 'Picker' },
          { name = 'Grep files', action = 'lua require("fzf-lua").live_grep()', section = 'Picker' },
          { name = 'Oil files', action = 'Oil', section = 'Picker' },
          starter.sections.recent_files(10, true),
          starter.sections.builtin_actions(),
        },
      }

      require('mini.bufremove').setup()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
