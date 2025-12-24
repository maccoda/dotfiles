return {
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      debugger = {
        enabled = true,
      },
      dev_logs = {
        focus_on_open = false,
      },
      widget_guides = {
        enabled = true,
      },
      lsp = {
        color = {
          enabled = true,
        },
        settings = {
          showTodos = false,
        },
      },
    },
  },
}
