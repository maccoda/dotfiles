-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Remove x as there are too many ways to change/delete things
vim.keymap.set('n', 'x', '<Nop>', { noremap = true })
-- Remove s as it is the same as cl
vim.keymap.set('n', 's', '<Nop>', { noremap = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Turn off search highlights when entering insert
vim.keymap.set('n', 'i', '<cmd>noh<CR>i', { noremap = true })
vim.keymap.set('n', 'I', '<cmd>noh<CR>I', { noremap = true })
vim.keymap.set('n', 'o', '<cmd>noh<CR>o', { noremap = true })
vim.keymap.set('n', 'O', '<cmd>noh<CR>O', { noremap = true })
vim.keymap.set('n', 'a', '<cmd>noh<CR>a', { noremap = true })
vim.keymap.set('n', 'A', '<cmd>noh<CR>A', { noremap = true })

vim.keymap.set({ 'n', 'v' }, 'mm', '%', { desc = 'Goto matching pair' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Goto last non-whitespace' })
vim.keymap.set({ 'n', 'v' }, 'gh', '^', { desc = 'Goto first non-whitespace' })
vim.keymap.set('v', '<leader>Y', '"+y', { desc = 'Yank to system clipboard' })

vim.keymap.set('n', '<leader>gg', function()
  io.popen 'zellij run -f -c --width 80% --height 80% -x 10% -y 10% -- lazygit'
end, { desc = 'Open lazygit' })
vim.keymap.set('n', '<leader>z', ':!zrf ', { desc = 'Start Zellij command' })

vim.keymap.set('n', ']x', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move line down' })
vim.keymap.set('n', '[x', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move line up' })

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>')
vim.keymap.set('n', '<leader>n', '<cmd>Fidget history<cr>')

-- Close current buffer without closing vim
vim.keymap.set('n', 'QQ', '<cmd>bprevious | bdelete #<cr>', { noremap = true, desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bprevious | bdelete #<cr>', { noremap = true, desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bo', function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= vim.api.nvim_get_current_buf() then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { noremap = true, desc = 'Close [o]ther [b]uffers' })

vim.keymap.set('n', '<leader>x', function()
  vim.diagnostic.config {
    virtual_text = false,
    virtual_lines = false,
  }
  local bufnr, winid = vim.diagnostic.open_float(nil, { focusable = false })
  if winid == nil then
    return
  end
  vim.api.nvim_create_autocmd({ 'FocusLost', 'CursorMoved' }, {
    group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
    once = true,
    callback = function()
      vim.diagnostic.config {
        virtual_text = { spacing = 2, prefix = '●', current_line = true, severity = { max = vim.diagnostic.severity.INFO } },
        virtual_lines = { current_line = true, severity = { min = vim.diagnostic.severity.WARN } },
      }
      if vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_win_close(winid, false)
      end
      return true
    end,
  })
end, { noremap = true, desc = 'Show diagnostic float' })

-- vim: ts=2 sts=2 sw=2 et
