return {
  'stevearc/aerial.nvim',
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set('n', '[[', '<cmd>AerialPrev<CR>', { buffer = bufnr, desc = 'Jump to previous symbol' })
      vim.keymap.set('n', ']]', '<cmd>AerialNext<CR>', { buffer = bufnr, desc = 'Jump to next symbol' })
    end,
  },
  keys = {
    { '<leader>aa', mode = { 'n' }, '<cmd>AerialToggle!<CR>', desc = 'Open aerial symbols window' },
    { '<leader>an', mode = { 'n' }, '<cmd>AerialNavToggle<CR>', desc = 'Navigate aerial symbols' },
  },
}
