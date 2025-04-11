-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})
-- Close all popup windows when focus is lost (like the above diagnostic window).
-- This is really useful because I typically run linters or others in another terminal
-- so I want it closed and start fresh
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative == "win" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end,
})

-- Wrap writing files
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.md", "*.tex", "*.txt" }, command = "setlocal textwidth=80" }
)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.jrnl" }, command = "setlocal textwidth=120" })
