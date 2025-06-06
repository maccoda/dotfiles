return {

  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      dim_inactive = true,
    },
  },
  { dir = "~/dev/irises.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "irises",
    },
  },
}
