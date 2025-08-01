return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = {
        spacing = 2,
        prefix = "●",
        current_line = true,
        severity = { max = vim.diagnostic.severity.INFO },
      },
      virtual_lines = { current_line = true, severity = { min = vim.diagnostic.severity.WARN } },
      float = { border = "rounded", source = "if_many" },
      underline = { severity = { min = vim.diagnostic.severity.WARN } },
      severity_sort = true,
    },
    inlay_hints = {
      enabled = false,
    },
  },
}
