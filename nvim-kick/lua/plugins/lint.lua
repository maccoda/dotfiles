return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufReadPost', 'InsertLeave' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = require('langs').linters

      lint.linters.golangcilint = lint.linters.golangcilint or {}
      lint.linters.golangcilint.cwd = function()
        local path = vim.api.nvim_buf_get_name(0)
        local dir = vim.fn.fnamemodify(path, ':p:h')
        while dir ~= '/' do
          if vim.fn.filereadable(dir .. '/go.mod') == 1 then
            return dir
          end
          dir = vim.fn.fnamemodify(dir, ':h')
        end
        return vim.fn.fnamemodify(path, ':p:h')
      end

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
