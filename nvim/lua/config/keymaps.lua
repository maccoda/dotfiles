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

if vim.opt.diff:get() then
  -- Define key mappings for diff mode
  vim.api.nvim_set_keymap(
    "n",
    "<localleader>1",
    ":diffget LOCAL<CR>",
    { noremap = true, silent = true, desc = "Choose local" }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<localleader>2",
    ":diffget BASE<CR>",
    { noremap = true, silent = true, desc = "Choose base" }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<localleader>3",
    ":diffget REMOTE<CR>",
    { noremap = true, silent = true, desc = "Choose remote" }
  )
end
