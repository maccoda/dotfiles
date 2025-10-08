return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  opts = function()
    local fzf = require 'fzf-lua'
    local actions = fzf.actions
    return {
      'ivy',
      -- Change the below options so hidden does not conflict with Zellij
      files = {
        cwd_prompt = false,
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-.'] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-.'] = { actions.toggle_hidden },
        },
      },
      keymap = {
        builtin = {
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
        },
      },
    }
  end,
  keys = {
    { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
    { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
    {
      '<leader>,',
      '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
      desc = 'Switch Buffer',
    },
    { '<leader>:', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
    { '<leader><space>', '<cmd>FzfLua<cr>', desc = 'FzfLua finder' },
    -- find
    { '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Buffers' },
    { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find Files (Root Dir)' },
    { '<leader>fg', '<cmd>FzfLua git_files<cr>', desc = 'Find Files (git-files)' },
    { '<leader>fr', '<cmd>lua require("fzf-lua").oldfiles({cwd_only = true})<cr>', desc = 'Recent' },
    -- git
    { '<leader>gC', '<cmd>FzfLua git_commits<CR>', desc = '[g]it [c]ommits' },
    { '<leader>gs', '<cmd>FzfLua git_status<CR>', desc = '[g]ti [s]tatus' },
    { '<leader>gc', '<cmd>FzfLua git_bcommits<CR>', desc = '[g]it buffer [c]ommits' },
    -- search
    { '<leader>s"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
    { '<leader>sa', '<cmd>FzfLua autocmds<cr>', desc = 'Auto Commands' },
    { '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Buffer' },
    { '<leader>sc', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
    { '<leader>sC', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document Diagnostics' },
    { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Workspace Diagnostics' },
    { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep (Root Dir)' },
    { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = 'Help Pages' },
    { '<leader>sH', '<cmd>FzfLua highlights<cr>', desc = 'Search Highlight Groups' },
    { '<leader>sj', '<cmd>FzfLua jumps<cr>', desc = 'Jumplist' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Key Maps' },
    { '<leader>sl', '<cmd>FzfLua loclist<cr>', desc = 'Location List' },
    { '<leader>sM', '<cmd>FzfLua man_pages<cr>', desc = 'Man Pages' },
    { '<leader>sm', '<cmd>FzfLua marks<cr>', desc = 'Jump to Mark' },
    { '<leader>sR', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
    { '<leader>sq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix List' },
    { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Word (Root Dir)' },
    { '<leader>sw', '<cmd>FzfLua grep_visual<cr>', mode = 'v', desc = 'Selection (Root Dir)' },
    {
      '<leader>st',
      function()
        require('fzf-lua').grep { search = '(TODO|FIXME|NOTE|HACK):', no_esc = true }
      end,
      desc = 'Search: TODOs',
    },
  },
}
