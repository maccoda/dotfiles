return {
  -- FIXME: Do not get this to run on exit
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    init = function()
      vim.api.nvim_create_user_command('Fmt', "lua require('conform').format({ lsp_fallback = true, async = true })", {})
    end,
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 1000,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = require('langs').formatters,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
