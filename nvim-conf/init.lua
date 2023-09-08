vim.call('plug#begin', '~/.vim/plugged')
local Plug = vim.fn['plug#']
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug 'nvim-lualine/lualine.nvim'
Plug("ibhagwan/fzf-lua", { branch = "main" })
Plug 'numToStr/Comment.nvim'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'luukvbaal/nnn.nvim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
Plug 'kylechui/nvim-surround'
Plug 'tpope/vim-repeat'
-- LSP plugins
Plug 'neovim/nvim-lspconfig'
Plug('williamboman/mason.nvim', { ['do'] = ':MasonUpdate' })
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
----------
-- cmp sources
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug('L3MON4D3/LuaSnip', { tag = 'v2.*' })
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug('tzachar/cmp-tabnine', { ['do'] = './install.sh' })
----------
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
-- Tree sitter modules
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-treesitter/nvim-treesitter-context'
----------
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })
Plug 'folke/todo-comments.nvim'
Plug 'NoahTheDuke/vim-just'
Plug 'simrat39/rust-tools.nvim'
Plug 'mfussenegger/nvim-lint'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'stevearc/dressing.nvim'
vim.call('plug#end')

-- Unmap some actions/commands
-- Remove x as there are too many ways to change/delete things
vim.api.nvim_set_keymap('n', 'x', '<Nop>', { noremap = true })
-- Remove r as again too many ways to change a letter, use cl instead
vim.api.nvim_set_keymap('n', 'r', '<Nop>', { noremap = true })

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
-- Set folds by tree sitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- Open all folds by default
vim.opt.foldenable = false
vim.api.nvim_create_autocmd(
    { "InsertLeave", "BufLeave", "FocusLost" },
    {
        callback = function(args)
            if args.file ~= nil and args.file ~= '' and vim.o.buftype ~= 'nowrite' and vim.o.buftype == '' then
                vim.cmd("silent wall")
            end
        end,
        desc = "Save all buffers on insert leave when it is a known file",
        -- See :h autocmd-nested, need this set so that linters, etc run after save
        nested = true
    }
)
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
-- Configure diff mode
vim.opt.diffopt = { internal = true, linematch = 60, filler = true }
-- Map the leader key
vim.g.mapleader = " "
-- Yanking will return to where cursor was prior to initiating the yank
vim.api.nvim_set_keymap('v', 'y', 'y`]', {})
-- Close current buffer without closing vim
vim.api.nvim_set_keymap('n', 'QQ', '<cmd>bprevious | bdelete #<cr>', { noremap = true })
-- Set spell check on certain files
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.md", "*.tex", "*.txt" }, command = "setlocal spell" }
)
-- Wrap writing files
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.md", "*.tex", "*.txt" }, command = "setlocal textwidth=80" }
)
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.jrnl" }, command = "setlocal textwidth=120" }
)
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.conf" }, command = "set filetype=conf" }
)

-- Quickly reload config
vim.api.nvim_set_keymap('n', '<leader>rr',
    '<cmd>luafile ~/.dotfiles/nvim-conf/init.lua<cr><cmd>echo "Config reloaded"<cr>', { noremap = true })

-- Yank current file path
vim.api.nvim_set_keymap('n', '<leader>yf', '<cmd>let @+ = expand("%")<cr>', { noremap = true })

-- Show some whitespace
vim.opt.listchars = { eol = '¬', tab = '>·', trail = '~', extends = '>', precedes = '<' }
vim.opt.list = true

-- Syntax theme
vim.opt.termguicolors = true

require("catppuccin").setup({
    flavour = "macchiato",
    dim_inactive = {
        enabled = true,
    },
    integrations = {
        gitsigns = true,
        leap = true,
        markdown = true,
        cmp = true,
        treesitter = true,
        mason = true,
        treesitter_context = true
    }
})

vim.cmd.colorscheme "catppuccin"

-- ======== FZF =============


local opts = { noremap = true }
vim.api.nvim_set_keymap('n', ';<space>', ':FzfLua ', opts)
vim.api.nvim_set_keymap('n', ';f', '<cmd>FzfLua files<cr>', opts)
vim.api.nvim_set_keymap('n', ';g', '<cmd>FzfLua live_grep_glob<cr>', opts)
vim.api.nvim_set_keymap('n', ';b', '<cmd>FzfLua buffers<cr>', opts)
vim.api.nvim_set_keymap('n', ';wg', '<cmd>FzfLua grep_cword<cr>', opts)
vim.api.nvim_set_keymap('n', ';s', '<cmd>FzfLua blines<cr>', opts)
vim.api.nvim_set_keymap('n', ';ld', '<cmd>FzfLua lsp_document_symbols<cr>', opts)

-- Open new sessions with find files window
vim.cmd([[
augroup ReplaceNetrw
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | bd | call luaeval("require('fzf-lua').files()") | endif
augroup END
]])

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
    options = {
        theme = 'catppuccin',
        component_separators = '│',
        section_separators = { left = '', right = '' },
    },
    extensions = {
        "fugitive", "quickfix"
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'FugitiveHead', icon = '' }, 'diagnostics' },
        lualine_c = { { '%=', separator = '' }, { 'filename', path = 1, shorting_target = 80 } },
        lualine_x = { 'filetype' },
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

-- Set the number of items shown in the completion window at one time
vim.opt.pumheight = 30

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
        ['<C-l>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        -- Order of the sources determines menu sort order
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'path' },
        {
            name = 'buffer',
            keyword_length = 3,
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
        },
        {
            name = 'cmp_tabnine',
        },
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol_text" })
            if entry.source.name == "cmp_tabnine" then
                local detail = (entry.completion_item.data or {}).detail
                vim_item.kind = " T9"
                if detail and detail:find('.*%%.*') then
                    vim_item.kind = vim_item.kind .. ' ' .. detail
                end

                if (entry.completion_item.data or {}).multiline then
                    vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                end
            end
            local maxwidth = 80
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true
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

-- == TabNine ==
-- To view local config type -> tabnine::config
local tabnine = require('cmp_tabnine.config')

tabnine:setup({
    max_lines = 1000,
    max_num_results = 10,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    show_prediction_strength = false
})

-- == LSP ==

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd(
    { "CursorHold" },
    {
        callback = function()
            vim.diagnostic.open_float(nil, { focusable = false })
        end
    }
)
-- Set updatetime for CursorHold
vim.opt.updatetime = 800
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config {
    virtual_text = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'if_many',
        header = '',
        prefix = '',
    },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "prosemd_lsp", "tsserver" }
})
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


local map_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', map_opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>lua vim.diagnostic.setloclist()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', map_opts)

-- Function to run when the LSP is attached to a buffer
local function common_on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>FzfLua lsp_declarations<CR>', map_opts)
    buf_set_keymap('n', 'gd', "<cmd>lua require('fzf-lua').lsp_definitions({jump_to_single_result = true})<CR>", map_opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
    buf_set_keymap('n', 'gi', '<cmd>FzfLua lsp_implementations<CR>', map_opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
    buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
    buf_set_keymap('n', '<leader>D', '<cmd>FzfLua lsp_typedefs<CR>', map_opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>', map_opts)
    buf_set_keymap('n', 'gr', '<cmd>lua require("fzf-lua").lsp_references({ ignore_current_line = true })<CR>', map_opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', map_opts)
end

vim.api.nvim_create_user_command("Fmt", "lua vim.lsp.buf.format{ async = true }", {})
vim.api.nvim_create_user_command("FishFmt", "Start fish_indent --write % | e", {})

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = common_on_attach,
            capabilities = capabilities
        }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()
        require("rust-tools").setup {
            on_attach = common_on_attach
        }
    end,
    -- Configure Lua LS just for Neovim configuration
    ["lua_ls"] = function()
        require('lspconfig').lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
    end
}

-- == tree-sitter ==
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "rust", "typescript", "javascript", "lua", "go" },
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- Disable treesitter for large files
        disable = function(_, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 50000
        end
    },
    autotag = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<cr>",
            node_incremental = "<cr>",
            scope_incremental = "<s-cr>",
            node_decremental = "<bs>",
        },
    },
}


-- == Comment ==
require('Comment').setup()

-- == Snippets ==
require("luasnip.loaders.from_vscode").lazy_load()
local ls = require("luasnip")
-- This will expand the current item or jump to the next item in the snippet
vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })
-- This will move backwards to the previous item in the snippet
vim.keymap.set({ "i", "s" }, "<c-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
-- Cycle through list of snippet options
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.choice_active() then
        require("luasnip.extras.select_choice")()
    end
end, { silent = true })

-- Comment snippets have now been separated
-- https://github.com/rafamadriz/friendly-snippets/issues/327
ls.filetype_extend("sh", { "shelldoc" })

-- == Auto Pairs ==
require('nvim-autopairs').setup()

-- ==== TODO ====
require("todo-comments").setup {
    signs = false
}
vim.api.nvim_create_user_command("TodoFzf",
    "lua require('fzf-lua').grep({ search = '(TODO|FIXME|NOTE|HACK):', no_esc = true })",
    {})

require('leap').add_default_mappings()
require('flit').setup()
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

require("nvim-surround").setup()

-- ====== NNN =======
local builtin = require("nnn").builtin
require("nnn").setup({
    mappings = {
        { "<C-t>", builtin.open_in_tab },       -- open file(s) in tab
        { "<C-s>", builtin.open_in_split },     -- open file(s) in split
        { "<C-v>", builtin.open_in_vsplit },    -- open file(s) in vertical split
        { "<C-p>", builtin.open_in_preview },   -- open file in preview split keeping nnn focused
        { "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
        { "<C-e>", builtin.populate_cmdline },  -- populate cmdline (:) with file(s)
    }
})
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>NnnPicker %:p<cr>', { noremap = true })

-- ===== Linting =====
require('lint').linters_by_ft = {
    markdown = { 'vale' },
    typescript = { 'eslint_d' },
    sh = { 'shellcheck'}
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

require('dressing').setup({
    select = {
        backend = { "builtin" }
    }
})
local metals_config = require("metals").bare_config()
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})
