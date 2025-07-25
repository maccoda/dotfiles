return {
  'stevearc/oil.nvim',
  opts = {
    keymaps = {
      ['<esc>'] = { 'actions.close', mode = 'n' },
      ['<C-s>'] = { 'actions.select', opts = { horizontal = true, close = true } },
      ['<C-v>'] = { 'actions.select', opts = { vertical = true, close = true } },
    },
  },
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
