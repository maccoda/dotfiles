call plug#begin("~/.vim/plugged")
    " Plugin Section
    " ==============
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'hoob3rt/lualine.nvim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'numToStr/Comment.nvim'
    Plug 'ggandor/lightspeed.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'thaerkh/vim-workspace'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-projectionist'
    Plug 'justinmk/vim-dirvish'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-unimpaired'
    " LSP plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    "====
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'blankname/vim-fish'
    Plug 'sbdchd/neoformat'
    Plug 'folke/trouble.nvim'
    Plug 'ryanoasis/vim-devicons'
call plug#end()


" Config Section
" =============
lua << EOF
  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.syntax = 'on'
  vim.o.tabstop = 4
  vim.o.softtabstop = 4
  vim.o.smarttab = true
  -- Indentation amount for < and > commands
  vim.o.shiftwidth = 4
  -- Insert spaces when tab is pressed
  vim.o.expandtab = true
  -- Copy indent from current line when start new line
  vim.o.autoindent = true
  vim.o.smartindent = true
  -- Highlight cursor line
  vim.o.cursorline = true
  vim.o.wrap = false
  -- Auto load from file useful when formatters run
  vim.o.autoread = true
  -- Open new split panes to the right and below
  vim.o.splitright = true
  vim.o.splitbelow = true
  -- Do not show the last command
  vim.o.showcmd = false
  -- Yank and paste with the system clipboard
  vim.o.clipboard = 'unnamed'
EOF

filetype plugin on

" Turn off search highlights when entering insert
nnoremap i :noh<CR>i
nnoremap I :noh<CR>I
nnoremap o :noh<CR>o
nnoremap O :noh<CR>O
nnoremap a :noh<CR>a
nnoremap A :noh<CR>A
nnoremap s :noh<CR>s
" Trim trailing white space on save
autocmd BufWritePre * %s/\s\+$//e
" Wrap markdown files to 80 column
au BufRead,BufNewFile *.md setlocal textwidth=80
" Wrap text files to 100 column
au BufRead,BufNewFile *.tex setlocal textwidth=80
" Set spell check in markdown and latex files
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell
" Show tabs and trailing whitespace
set list listchars=tab:>-,trail:.,extends:>
" Use hidden to keep things like undo history present when change buffer
set hidden
" Map the leader key
let mapleader = " "
" Improve search in file (similar to other editors)
set ignorecase
set smartcase

" Allow mouse mode because sometimes we just want to click
set mouse=nv

" Yanking will return to where cursor was prior to initiating the yank
vmap y y`]

" Vim likes a POSIX compatible shell
if &shell =~# 'fish$'
    set shell=bash
endif

" Close current buffer without closing vim
nnoremap <leader>b :bunload<CR>
nnoremap <leader>B :bdelete<CR>

" Yank current file path to clipboard
nnoremap <leader>yp :let @+=expand("%:p")<CR>
" =========

" TODO: Convert this to lua

command! WFiles call fzf#run(fzf#wrap({'options': ['--query', expand('<cword>')]}))
command! WGrep call RipgrepFzf(expand('<cword>'), <bang>0)

nnoremap ;wf :WFiles<CR>
nnoremap ;wg :WGrep<CR>

" Syntax theme
set termguicolors

lua << EOF
  vim.g.tokyonight_style = "night"

  vim.cmd[[colorscheme tokyonight]]
EOF


" == FZF fuzzy finder ==
nnoremap ;f :Files<cr>
nnoremap ;g :RG<cr>
nnoremap ;b :Buffers<cr>
nnoremap ;w :Windows<cr>

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \}
" Use fd - does not include ignored by git files
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden -E .git -E .undodir'
" Below function taken from fzf.vim readme, it will invoke rg on each change
" when performing search
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s; or true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Place the window in the centre of the screen
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
" Single escape exits
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>


" == Git signs ==
lua << EOF
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
EOF

" == Lightspeed ==
" Remap
map ]s <Plug>Lightspeed_s
map [s <Plug>Lightspeed_S

" == Lualine ==
lua << EOF
local function window()
  return vim.api.nvim_win_get_number(0)
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require('lualine').setup{
    options = {
        theme = 'tokyonight',
        section_separators = '',
        component_separators = ''
    },
    extensions = {
        "fugitive", "quickfix"
    },
    sections = {
        lualine_a = {window, 'mode'},
        lualine_b = { {'FugitiveHead', icon = ''}, {'diff', source = diff_source} },
    },
    inactive_sections = {
        lualine_a = {window}
    }

}
EOF

" == Fugitive ==
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" == Vim Workspace ==
" If open a specific file do not try open a workspace
let g:workspace_session_disable_on_args = 1
nnoremap <leader>qw :CloseHiddenBuffers<CR>
let g:workspace_autosave_always = 1

" == Cmp ==
"
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF




" == LSP ==
lua << EOF
local nvim_lsp = require('lspconfig')


local lsp_installer = require("nvim-lsp-installer")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        -- Mappings.
        local map_opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', map_opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', map_opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', map_opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', map_opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', map_opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', map_opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', map_opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', map_opts)
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", map_opts)
    end

    opts.on_attach = on_attach
    opts.capabilities = capabilities

    server:setup(opts)
end)

EOF


" == tree-sitter ==
lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


" == Comment ==
lua require('Comment').setup()


" == Trouble ==
lua << EOF
require("trouble").setup {
        icons = false,
        auto_preview = false
    }
EOF
