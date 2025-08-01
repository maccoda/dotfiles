return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = { preset = "default" },
      sources = {
        per_filetype = { oil = { "buffer" } },
      },
      completion = {
        menu = {
          auto_show = false,
        },
        ghost_text = { show_with_menu = false },
      },
    },
  },
  {
    "Exafunction/codeium.nvim",
    opts = {
      virtual_text = {
        enabled = true,
      },
    },
  },
}
