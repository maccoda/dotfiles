return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    search = {
      multi_window = false,
    },
    modes = {
      treesitter_search = {
        label = {
          style = "overlay",
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "gw", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "gW", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
