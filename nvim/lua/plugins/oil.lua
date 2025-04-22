return {
  "stevearc/oil.nvim",
  opts = {
    keymaps = {
      ["<esc>"] = { "actions.close", mode = "n" },
    },
  },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
