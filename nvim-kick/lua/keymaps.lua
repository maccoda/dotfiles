-- [[ Basic Keymaps ]]
vim.keymap.set('i', '<C-[>', '<Esc>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Remove x as there are too many ways to change/delete things
vim.keymap.set('n', 'x', '<Nop>', { noremap = true })
-- Remove s as it is the same as cl
vim.keymap.set('n', 's', '<Nop>', { noremap = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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

vim.keymap.set('n', '<leader>gg', function()
  io.popen 'fish -c lg'
end, { desc = 'Open lazygit' })
vim.keymap.set('n', '<leader>z', ':silent !zri ', { desc = 'Start Zellij command' })

vim.keymap.set('n', ']x', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move line down' })
vim.keymap.set('n', '[x', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move line up' })

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open lazy.nvim' })

-- Close current buffer without closing vim
vim.keymap.set('n', '<leader>bd', function()
  MiniBufremove.delete()
end, { noremap = true, desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bo', function()
  -- Close other windows
  vim.cmd 'wincmd o'
  -- Close other buffers
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
        virtual_text = { spacing = 2, prefix = '●', current_line = true },
      }
      if vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_win_close(winid, false)
      end
      return true
    end,
  })
end, { noremap = true, desc = 'Show diagnostic float' })

-- vim: ts=2 sts=2 sw=2 et
