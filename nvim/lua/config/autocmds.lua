-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Wrap writing files
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.md", "*.tex", "*.txt" }, command = "setlocal textwidth=80" }
)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.jrnl" }, command = "setlocal textwidth=120" })

-- Auto save on focus lost
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  callback = function(args)
    if args.file ~= nil and args.file ~= "" and vim.o.buftype ~= "nowrite" and vim.o.buftype == "" then
      vim.cmd("silent wall")
    end
  end,
  desc = "Save all buffers on insert leave when it is a known file",
  -- See :h autocmd-nested, need this set so that linters, etc run after save
  nested = true,
})

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local bufnr, winid = vim.diagnostic.open_float(nil, { focusable = false })

    if winid == nil then
      return
    end
    vim.api.nvim_create_autocmd("FocusLost", {
      group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
      once = true,
      callback = function()
        if vim.api.nvim_win_is_valid(winid) then
          vim.api.nvim_win_close(winid, false)
        end
        return true
      end,
    })
  end,
})
