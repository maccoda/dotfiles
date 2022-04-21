call plug#begin("~/.vim/plugged")
    " Plugin Section
    " ==============
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'EdenEast/nightfox.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'numToStr/Comment.nvim'
    Plug 'ggandor/lightspeed.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'thaerkh/vim-workspace'
    Plug 'windwp/nvim-autopairs'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-projectionist'
    Plug 'justinmk/vim-dirvish'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    " LSP plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'onsails/lspkind-nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    "====
    " cmp sources
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'andersevenrud/cmp-tmux'
    "====
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    " Tree sitter modules
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'windwp/nvim-ts-autotag'
    Plug 'romgrk/nvim-treesitter-context'
    "====
    Plug 'blankname/vim-fish'
    Plug 'sbdchd/neoformat'
    Plug 'folke/trouble.nvim'
    Plug 'junegunn/gv.vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'folke/twilight.nvim'
    Plug 'folke/zen-mode.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
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
au BufRead,BufNewFile *.jrnl setlocal textwidth=120
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
nnoremap ;wg <cmd>lua require('telescope.builtin').grep_string()<CR>

" Quickly reload config
nnoremap <leader>r :source ~/.dotfiles/nvim-conf/init.vim<CR>:echo "Config reloaded"<CR>
" Syntax theme
set termguicolors

lua << EOF
  vim.g.tokyonight_style = "night"
  vim.cmd 'colorscheme nightfox'

EOF


" == FZF fuzzy finder ==
nnoremap ;f <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap ;g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap ;b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap ;w :Windows<cr>
nnoremap ;of <cmd>lua require('telescope.builtin').oldfiles()<cr>

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

lua << EOF
require("telescope").load_extension('fzy_native')

require("telescope").setup {
  pickers = {
    live_grep = {
      additional_args = function(opts)
          return {"--hidden", "--glob", "!__snapshots__"}
      end
      },
    oldfiles = {
        only_cwd = true
      }
    }
  }
EOF


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
    extensions = {
        "fzf","fugitive", "quickfix", "symbols-outline"
    },
    sections = {
        lualine_a = {window, 'mode'},
        lualine_b = { {'FugitiveHead', icon = ''}, {'diff', source = diff_source} },
        lualine_c = {{'filename', path = 1, shorting_target = 80}}
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
" Limit the number of items to 10 in popup window
set pumheight=10

set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'
  local lspkind = require('lspkind')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'vsnip' },
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
      },
      { name = 'tmux', max_item_count = 3 }
    }),
    formatting = {
    format = lspkind.cmp_format {
          with_text = true,
          maxwidth = 50,
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
            vsnip = "[snip]",
            tmux = "[tmux]"
          },
     }},
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
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', map_opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', map_opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', map_opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', map_opts)
end

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
    local opts = {on_attach = common_on_attach}


    if server.name == "eslint" then
        opts.on_attach = function (client, bufnr)
            -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
            -- the resolved capabilities of the eslint server ourselves!
            client.resolved_capabilities.document_formatting = true
            common_on_attach(client, bufnr)
        end
        opts.settings = {
            format = { enable = true }, -- this will enable formatting
        }
    end
    -- Prefer eslint over tsserver formatting
    if server.name == "tsserver" then
      opts.on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          common_on_attach(client, bufnr)
      end
    end

    opts.capabilities = capabilities

    server:setup(opts)
end)

EOF

" == null-ls ==
lua <<EOF
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.proselint,
        require("null-ls").builtins.code_actions.proselint
    },
})
EOF


" == tree-sitter ==
lua <<EOF
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
EOF


" == Comment ==
lua require('Comment').setup()


" == Trouble ==
lua << EOF
require("trouble").setup {
        icons = false,
        auto_preview = false,
        mode = "document_diagnostics",
        height = 8
    }
EOF
nnoremap <leader>xx <cmd>TroubleToggle<cr>

" == Snippets ==

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" == Auto Pairs ==
lua << EOF
    require('nvim-autopairs').setup()
EOF

" == Colorizer ==
lua require'colorizer'.setup()

" == Twilight ==
lua require("twilight").setup()
" == Zen Mode ==
lua << EOF
require("zen-mode").setup {
  window = {
    width = .85
    }
  }
EOF
nnoremap <leader>z <cmd>ZenMode<cr>
