return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "nvim-mini/mini.nvim", "folke/lazydev.nvim" },
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      snippets = { preset = "mini_snippets" },
      cmdline = { enabled = false },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { "lsp", "path", "snippets", "lazydev", "buffer" },
        providers = { lazydev = { module = "lazydev.integrations.blink", score_offset = 100 } },
      },
      signature = { enabled = true },
    },
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        keybindings = {
          next = "<C-'",
          prev = "<C-;",
        },
        idle_delay = 1000,
      },
    },
  },
  {
    "github/copilot.vim",
    enabled = false,
    config = function()
      vim.g.copilot_assume_mapped = true
      vim.keymap.set("i", "<C-'>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-;>", "<Plug>(copilot-previous)")
      vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<cr>")
      -- This will show it with the completion window. Need to decide which we want to take a priority on
      vim.g.copilot_hide_during_completion = "0"
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
