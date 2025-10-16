return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = function()
      local ts = require 'nvim-treesitter'
      ts.install(require('langs').ts_installed)
      ts.update()
    end,
  },
  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<A-o>',
          node_incremental = '<A-o>',
          scope_incremental = '<A-O>',
          node_decremental = '<A-i>',
        },
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    depends = 'nvim-treesitter/nvim-treesitter',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {},
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'BufReadPre',
    opts = {},
  },
}
-- vim: ts=2 sts=2 sw=2 et
