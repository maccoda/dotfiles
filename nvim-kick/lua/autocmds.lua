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
