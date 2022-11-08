vim.call('plug#begin', '~/.vim/plugged')
local Plug = vim.fn['plug#']
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug('nvim-telescope/telescope.nvim', { branch = '0.1.x' })
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
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
----------
-- cmp sources
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
Plug('L3MON4D3/LuaSnip', { tag = 'v1.*' })
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
----------
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'lewis6991/gitsigns.nvim'
-- Tree sitter modules
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'windwp/nvim-ts-autotag'
Plug 'romgrk/nvim-treesitter-context'
----------
Plug 'blankname/vim-fish'
Plug 'sbdchd/neoformat'
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })
Plug 'folke/zen-mode.nvim'
Plug 'folke/twilight.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'NoahTheDuke/vim-just'
Plug 'simrat39/rust-tools.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'karb94/neoscroll.nvim'
vim.call('plug#end')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- Indentation amount for < and > commands
vim.opt.shiftwidth = 4
-- Insert spaces when tab is pressed
vim.opt.expandtab = true
-- Copy indent from current line when start new line
vim.opt.smartindent = true
-- Highlight cursor line
vim.opt.cursorline = true
vim.opt.wrap = false
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
    { "InsertLeave", "BufLeave", "FocusLost" },
    { command = "wall" }
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
    { pattern = { "*.md", "*.tex" }, command = "setlocal spell" }
)
-- Trim trailing white space on save
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { command = "%s/\\s\\+$//e" }
)
-- Wrap writing files
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.md", "*.tex" }, command = "setlocal textwidth=80" }
)
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.jrnl" }, command = "setlocal textwidth=120" }
)

-- Quickly reload config
vim.api.nvim_set_keymap('n', '<leader>rr',
    '<cmd>luafile ~/.dotfiles/nvim-conf/init.lua<cr><cmd>echo "Config reloaded"<cr>', { noremap = true })

-- Show some whitespace
vim.cmd([[
    set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
    set list
]])
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
vim.keymap.set('n', ';f', builtin.find_files, opts)
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
                return { "--hidden", "--glob", "!__snapshots__", "--glob", "!.git" }
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
            opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
        map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

        -- Actions
        map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
        map('v', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
        map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
        map('v', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
        map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    end
}

-- == Lualine ==

require('lualine').setup {
    extensions = {
        "fugitive", "quickfix"
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'FugitiveHead', icon = '' } },
        lualine_c = { { 'filename', path = 1, shorting_target = 80 } }
    },
    tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'buffers', mode = 2 } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' }
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
local cmp = require 'cmp'
local lspkind = require('lspkind')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local luasnip = require('luasnip')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }) -- Same ins-completion mapping and never replace
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
        { name = 'luasnip' },
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
        }
    },
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
    { callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
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
    ensure_installed = { "prosemd_lsp", "tsserver", "eslint" }
})

local map_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', map_opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', map_opts)

-- Function to run when the LSP is attached to a buffer
local function common_on_attach(client, bufnr)
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
    if lsp.name ~= 'rust_analyzer' then
        nvim_lsp[lsp.name].setup {
            on_attach = common_on_attach,
            capabilities = capabilities
        }
    end
end

local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = common_on_attach
    },
})



-- == tree-sitter ==
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "rust", "typescript", "javascript", "lua" },
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
require("luasnip.loaders.from_vscode").lazy_load()
local ls = require("luasnip")
-- This will expand the current item or jump to the next item in the snippet
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })
-- This will move backwards to the previous item in the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
-- Cycle through list of snippet options
vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

-- == Auto Pairs ==
require('nvim-autopairs').setup()

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

require("twilight").setup()


require("todo-comments").setup {
    signs = false
}
