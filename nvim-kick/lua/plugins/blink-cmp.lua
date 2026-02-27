return {
  {
    'Exafunction/codeium.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      enable_cmp_source = false,
    },
  },
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_assume_mapped = true
      vim.keymap.set('i', "<C-'>", '<Plug>(copilot-next)')
      vim.keymap.set('i', '<C-;>', '<Plug>(copilot-previous)')
      vim.keymap.set('n', '<leader>cp', '<cmd>Copilot panel<cr>')
      -- This will show it with the completion window. Need to decide which we want to take a priority on
      vim.g.copilot_hide_during_completion = '0'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
