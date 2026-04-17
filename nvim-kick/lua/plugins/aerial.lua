return {
  "stevearc/aerial.nvim",
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Jump to previous symbol" })
      vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Jump to next symbol" })
    end,
    nav = {
      keymaps = {
        ["q"] = "actions.close",
        ["L"] = "actions.jump",
      },
    },
    layout = {
      placement = "edge",
    },
    attach_mode = "global",
  },
  keys = {
    { "<leader>aa", mode = { "n" }, "<cmd>AerialToggle!<CR>", desc = "Open aerial symbols window" },
    { "<leader>an", mode = { "n" }, "<cmd>AerialNavToggle<CR>", desc = "Navigate aerial symbols" },
    { "<leader>ap", '<cmd>lua require("aerial").fzf_lua_picker()<cr>', desc = "[A]erial symbol [p]icker" },
  },
}
