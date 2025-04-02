return {

  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      overrides = {
        LspReferenceRead = { bg = "#3c3836", fg = "#fabd2f", bold = true },
        LspReferenceText = { bg = "#3c3836", fg = "#fabd2f", bold = true },
        LspReferenceWrite = { bg = "#d65d0e", fg = "#fabd2f", bold = true },
      },
      dim_inactive = true,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
