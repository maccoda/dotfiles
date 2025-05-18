-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "mm", "%", { desc = "Goto matching pair" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "Goto last non-whitespace" })
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "Goto first non-whitespace" })
vim.keymap.set("v", "<leader>Y", '"+y', { desc = "Yank to system clipboard" })

vim.keymap.set("n", "<leader>gg", function()
  io.popen("zellij run -f -c --width 80% --height 80% -x 10% -y 10% -- lazygit")
end)

-- Remove the built in exchange line
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")
vim.keymap.set("n", "]x", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "[x", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move line up" })

-- Only show the virtual lines when requested then remove when we move the cursor
vim.keymap.set("n", "<leader>k", function()
  vim.diagnostic.config({ virtual_lines = { current_line = true } })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
    callback = function()
      vim.diagnostic.config({ virtual_lines = false })
      return true
    end,
  })
end)
