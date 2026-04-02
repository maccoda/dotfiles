return {
  {
    "sschleemilch/slimline.nvim",
    opts = {
      -- Merge of the pure and stealth recipes
      style = "fg",
      bold = true,
      hl = {
        primary = "StatusLine",
        secondary = "StatusLineNC",
        base = "StatusLine",
        base_inactive = "StatusLineNC",
      },
      configs = {
        path = {
          hl = {
            primary = "Label",
          },
        },
        git = {
          hl = {
            primary = "Function",
          },
        },
        filetype_lsp = {
          hl = {
            primary = "String",
          },
        },
        progress = {
          follow = false,
        },
      },
      spaces = {
        components = "",
        left = "",
        right = "",
      },
    },
  },
}
