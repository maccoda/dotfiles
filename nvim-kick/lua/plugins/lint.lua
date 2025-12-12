return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufReadPost', 'InsertLeave' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = require('langs').linters

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            local client = vim.lsp.get_clients({ bufnr = 0 })[1] or {}
            local root_dir = client.root_dir
            if root_dir == nil then
              root_dir = vim.fn.getcwd()
            end
            lint.try_lint(nil, { cwd = root_dir })
            -- Always run the below irrespective of filetype
            lint.try_lint 'typos'
          end
        end,
      })
    end,
  },
}
