return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = ' ',
      },
      scope = {
        char = '┊',
        highlight = 'Cursor',
        show_end = false,
        show_start = false,
      },
    },
  },
  {
    -- Guess the indentation pattern of a file
    'nmac427/guess-indent.nvim',
    opts = {},
  },
}
