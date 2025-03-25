return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      -- Remove the buffer completions
      default = { "lsp", "path", "snippets" },
    },
  },
}
