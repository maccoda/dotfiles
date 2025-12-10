-- Wrap writing files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*.md', '*.tex', '*.txt' }, command = 'setlocal textwidth=80' })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*.jrnl' }, command = 'setlocal textwidth=120' })

-- Auto save on focus lost
vim.api.nvim_create_autocmd({ 'FocusLost' }, {
  callback = function(args)
    if args.file ~= nil and args.file ~= '' and vim.o.buftype ~= 'nowrite' and vim.o.buftype == '' then
      vim.cmd 'silent wall'
    end
  end,
  desc = 'Save all buffers on insert leave when it is a known file',
  -- See :h autocmd-nested, need this set so that linters, etc run after save
  nested = true,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'fugitive',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- https://gist.github.com/karenyyng/f19ff75c60f18b4b8149?permalink_comment_id=5073750#gistcomment-5073750
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.opt.diff:get() then
      vim.api.nvim_set_keymap('n', '<leader>1', ':diffget LOCAL<CR>', { noremap = true, silent = true, desc = 'Choose local' })
      vim.api.nvim_set_keymap('n', '<leader>2', ':diffget BASE<CR>', { noremap = true, silent = true, desc = 'Choose base' })
      vim.api.nvim_set_keymap('n', '<leader>3', ':diffget REMOTE<CR>', { noremap = true, silent = true, desc = 'Choose remote' })
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*.mjml' }, command = 'set syntax=html' })
