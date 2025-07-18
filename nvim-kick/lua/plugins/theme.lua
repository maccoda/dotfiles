return {

  {
    dir = '~/dev/irises.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      vim.cmd.colorscheme 'irises'
    end,
  },
}
