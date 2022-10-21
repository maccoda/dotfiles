vim.call('plug#begin', '~/.vim/plugged')
local Plug = vim.fn['plug#']
    Plug 'antoinemadec/FixCursorHold.nvim'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug('nvim-telescope/telescope.nvim', { branch = '0.1.x' })
    Plug('nvim-telescope/telescope-fzf-native.nvim', { do= 'make' })
    Plug 'numToStr/Comment.nvim'
    Plug 'ggandor/lightspeed.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'windwp/nvim-autopairs'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-projectionist'
    Plug 'justinmk/vim-dirvish'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    -- LSP plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'onsails/lspkind-nvim'
    --====
    -- cmp sources
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    --====
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    -- Tree sitter modules
    Plug('nvim-treesitter/nvim-treesitter', {do= ':TSUpdate'})
    Plug 'windwp/nvim-ts-autotag'
    Plug 'romgrk/nvim-treesitter-context'
    --====
    Plug 'blankname/vim-fish'
    Plug 'sbdchd/neoformat'
    Plug('iamcco/markdown-preview.nvim', { do= 'cd app && yarn install'  })
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'folke/zen-mode.nvim'
    Plug 'folke/twilight.nvim'
    Plug 'NoahTheDuke/vim-just'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'karb94/neoscroll.nvim'
    -- Work
    Plug 'amadeus/vim-mjml'
    Plug 'scalameta/nvim-metals'
    Plug 'sindrets/diffview.nvim'
vim.call('plug#end')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.syntax = 'on'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
-- Indentation amount for < and > commands
vim.opt.shiftwidth = 4
-- Insert spaces when tab is pressed
vim.opt.expandtab = true
-- Copy indent from current line when start new line
vim.opt.autoindent = true
vim.opt.smartindent = true
-- Highlight cursor line
vim.opt.cursorline = true
vim.opt.wrap = false
-- Auto load from file useful when formatters run
vim.opt.autoread = true
-- Open new split panes to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Do not show the last command
vim.opt.showcmd = false
-- Yank and paste with the system clipboard
vim.opt.clipboard = 'unnamed'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.autowriteall = true
vim.api.nvim_create_autocmd(
    {"InsertLeave", "BufLeave"},
    {command = "wall"}
)
-- Open all folds by default
vim.opt.foldenable = false
-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.opt.signcolumn = 'yes'
-- Turn off search highlights when entering insert
vim.api.nvim_set_keymap('n', 'i', '<cmd>noh<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', 'I', '<cmd>noh<CR>I', { noremap = true })
vim.api.nvim_set_keymap('n', 'o', '<cmd>noh<CR>o', { noremap = true })
vim.api.nvim_set_keymap('n', 'O', '<cmd>noh<CR>O', { noremap = true })
vim.api.nvim_set_keymap('n', 'a', '<cmd>noh<CR>a', { noremap = true })
vim.api.nvim_set_keymap('n', 'A', '<cmd>noh<CR>A', { noremap = true })
-- Use hidden to keep things like undo history present when change buffer
vim.opt.hidden = true
-- Improve search in file (similar to other editors)
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Allow mouse mode because sometimes we just want to click
vim.opt.mouse = 'nv'
-- Map the leader key
vim.g.mapleader = " "
-- Yanking will return to where cursor was prior to initiating the yank
vim.api.nvim_set_keymap('v', 'y', 'y`]', {})
-- Close current buffer without closing vim
vim.api.nvim_set_keymap('n', 'QQ', '<cmd>bprevious | bdelete #<cr>', { noremap = true })
-- Close current buffer and window
vim.api.nvim_set_keymap('n', 'QZ', '<cmd>bdelete<cr><c-w>c', { noremap = true })
-- Set spell check on certain files
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.md", "*.tex" }, command = "setlocal spell"}
)
-- Trim trailing white space on save
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { command = "%s/\\s\\+$//e"}
)
-- Wrap writing files
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.md", "*.tex" }, command = "setlocal textwidth=80"}
)
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.jrnl" }, command = "setlocal textwidth=120"}
)

--" Quickly reload config
-- nnoremap <leader>rr :source ~/.dotfiles/nvim-conf/init.vim<CR>:echo "Config reloaded"<CR>
-- Syntax theme
vim.opt.termguicolors = true
require('nightfox').setup({
options = {
  dim_inactive = true,
  modules = {
    cmp = true,
    telescope = true,
    lightspeed = true,
    treesitter = true,
    gitsigns = true
  }
}
})

vim.cmd('colorscheme nightfox')


-- == Telescope fuzzy finder ==

local builtin = require('telescope.builtin')
local opts = { noremap = true }
vim.keymap.set('n', ';f',builtin.find_files, opts)
vim.keymap.set('n', ';g', builtin.live_grep, opts)
vim.keymap.set('n', ';b', builtin.buffers, opts)
vim.keymap.set('n', ';of', builtin.oldfiles, opts)
vim.keymap.set('n', ';wg', builtin.grep_string, opts)
vim.keymap.set('n', ';s', builtin.current_buffer_fuzzy_find, opts)
vim.keymap.set('n', ';ld', builtin.lsp_document_symbols, opts)
vim.keymap.set('n', ';lw', builtin.lsp_workspace_symbols, opts)
vim.keymap.set('n', ';t', builtin.treesitter, opts)
vim.keymap.set('n', ';;', builtin.builtin, opts)
require('telescope').load_extension('fzf')

require("telescope").setup {
  pickers = {
    live_grep = {
      additional_args = function(opts)
        -- Below additional arguments are provided to ripgrep
          return {"--hidden", "--glob", "!__snapshots__", "--glob", "!.git"}
      end
      },
    find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--exclude", ".git" },
        hidden = true
      },
    oldfiles = {
        only_cwd = true
      }
    }
  }


-- == Git signs ==
require('gitsigns').setup {
    current_line_blame = true,
    on_attach = function(bufnr)
        local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
        map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

        -- Actions
        map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
        map('v', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
        map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
        map('v', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
        map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    end
}

-- == Lualine ==
local function window()
  return vim.api.nvim_win_get_number(0)
end

require('lualine').setup{
    extensions = {
        "fugitive", "quickfix"
    },
    sections = {
        lualine_a = {window, 'mode'},
        lualine_b = { {'FugitiveHead', icon = ''} },
        lualine_c = {{'filename', path = 1, shorting_target = 80}}
    },
    inactive_sections = {
        lualine_a = {window}
    },
    tabline = {
      lualine_a = {{'buffers', mode = 2}},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'tabs'}
    }
}
vim.api.nvim_set_keymap('n', '<leader>b', ':LualineBuffersJump<space>', { noremap = true })

-- == Fugitive ==
-- Fugitive Conflict Resolution
  vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>Gvdiffsplit!<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'gdh', '<cmd>diffget //2<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'gdl', '<cmd>diffget //3<cr>', { noremap = true })

-- == Cmp ==
  -- menuone: popup even when there's only one match
  -- noinsert: Do not insert text until a selection is made
  -- noselect: Do not select, force user to select one from the menu
  vim.opt.completeopt = "menuone,noinsert,noselect"
  -- Avoid showing extra messages when using completion
  vim.opt.shortmess:append({ c = true })
  local cmp = require'cmp'
  local lspkind = require('lspkind')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<tab>'] = cmp.config.disable, -- Mapping to ins-completion
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert}), -- Same ins-completion mapping and never replace
    }),
    sources = cmp.config.sources({
    -- Order of the sources determines menu sort order
      {
          name = 'nvim_lsp',
          max_item_count = 20,
          priority = 5,
      },
      { name = 'nvim_lsp_signature_help' },
      { name = 'path' },
      {
        name = 'vsnip',
        max_item_count = 15,
      },
      { name = 'buffer',
        max_item_count = 5,
        option = {
        get_bufnrs = function()
        -- Look in all buffers
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
        }
      }
    }),
    formatting = {
    format = lspkind.cmp_format {
          with_text = true,
          maxwidth = 50,
     }},
     window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
     }
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

-- == LSP ==

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd(
  { "CursorHold" },
  { callback = function ()
      vim.diagnostic.open_float(nil, { focusable = false})
    end
  }
)
-- Set updatetime for CursorHold
vim.opt.updatetime = 500
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config {
  virtual_text = false,
}

local nvim_lsp = require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp_installer.setup({
  ensure_installed = {"prosemd_lsp", "tsserver", "eslint"}
})

local map_opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', map_opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', map_opts)

-- Function to run when the LSP is attached to a buffer
function common_on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', map_opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
    buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', map_opts)
end

local servers = lsp_installer.get_installed_servers()
for _, lsp in pairs(servers) do
  nvim_lsp[lsp.name].setup {
    on_attach = common_on_attach,
    capabilities = capabilities
  }
end



-- == tree-sitter ==
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"rust", "typescript", "javascript", "lua"},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    autotag = {
      enable = true
    }
}


-- == Comment ==
require('Comment').setup()

-- == Snippets ==

-- Expand
vim.api.nvim_set_keymap('i', '<C-j>', [[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>']], {expr = true})
vim.api.nvim_set_keymap('s', '<C-j>', [[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>']], {expr = true})

-- Expand or jump
vim.api.nvim_set_keymap('i', '<C-l>', [[vsnip#available() ? '<Plug>(vsnip-expand)' : '<C-l>']], {expr = true})
vim.api.nvim_set_keymap('s', '<C-l>', [[vsnip#available() ? '<Plug>(vsnip-expand)' : '<C-l>']], {expr = true})

-- Jump forward or backward
vim.api.nvim_set_keymap('i', '<Tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], {expr = true})

-- If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
vim.g.vsnip_filetypes = { javascriptreact = { 'javascript' }, typescriptreact = { 'typescript' }}

-- == Auto Pairs ==
require('nvim-autopairs').setup()

-- == Colorizer ==
require("colorizer").setup()

-- == Zen Mode ==
require("zen-mode").setup {
  window = {
    width = .85
    },
  plugins = {
    kitty = {
      enabled = true,
      font = "+4",
      }
    }
  }
vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>ZenMode<cr>', { noremap = true })

require('neoscroll').setup()

require("twilight").setup {
-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
}
