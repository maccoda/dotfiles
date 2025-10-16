return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'helix',
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it hunk' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>d', group = '[D]ebug' },
        { 'gr', group = 'LSP' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>h', group = '[H]arpoon' },
      },
    },
  },
}
