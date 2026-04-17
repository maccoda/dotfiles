return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = function()
      local ts = require("nvim-treesitter")
      ts.install(require("langs").ts_installed)
      ts.update()
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = require("langs").ts_filetypes,
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    depends = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        move = {
          -- whether to set jumps in the jumplist
          set_jumps = true,
        },
      })
      vim.keymap.set({ "n", "x", "o" }, "]m", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]]", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[m", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[[", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
      end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = {
      -- Avoid the sticky context from growing a lot.
      max_lines = 3,
      -- Match the context lines to the source code.
      multiline_threshold = 1,
      -- Disable it when the window is too small.
      min_window_height = 20,
    },
    keys = {
      { "<leader>tx", "<cmd>TSContext toggle<cr>", desc = "Toggle treesitter context" },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
