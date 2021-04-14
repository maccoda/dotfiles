" Ensure ALE and CoC play nice
let g:ale_disable_lsp = 1

call plug#begin("~/.vim/plugged")
    " Plugin Section
    " ==============
    Plug 'Luxed/ayu-vim'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'drewtempelmeyer/palenight.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug '907th/vim-auto-save'
    Plug 'preservim/nerdcommenter'
    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-fugitive'
    Plug 'dag/vim-fish'
    Plug 'tpope/vim-sensible'
    Plug 'sheerun/vim-polyglot'
    Plug 'thaerkh/vim-workspace'
    Plug 'dense-analysis/ale'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-dispatch'
call plug#end()

" Config Section
" =============
set number relativenumber
syntax on
filetype plugin on
set tabstop=4
set softtabstop=4
set smarttab
" Indentation amount for < and > commands
set shiftwidth=2
" Insert spaces when tab is pressed
set expandtab
" Copy indent from current line when start new line
set autoindent
set smartindent
" Highlight curosr line
set cursorline

set nowrap
" Auto load from file useful when formatters run
set autoread

" Do not show the last command
set noshowcmd
" Yank and paste with the system clipboard
set clipboard=unnamed
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

" =========
" Personal plugins
" =========
" Open files with current file name, useful for finding tests
function! CurrentFileName()
    return expand('%:t:r')
endfunction

function! TestFile()
    call fzf#run(fzf#wrap({'options': ['--query', CurrentFileName() . 'T']}))
endfunction

command! TFiles call TestFile()

nnoremap <leader>t :TFiles<CR>

" Easily swap between previous and next buffer
nnoremap [w :bprevious<CR>
nnoremap ]w :bnext<CR>

" Close current buffer without closing vim
nnoremap <leader>w :bunload<CR>
nnoremap <leader>W :bdelete<CR>

" =========


" Syntax theme
set termguicolors
" Ayu
"let ayucolor="mirage"
"let g:airline_theme='bubblegum'
" Color cursorline a little more grey than theme
"highlight CursorLine cterm=NONE guibg=#2c313b guifg=NONE
" Color vertical split line same gray as above
"highlight VertSplit guibg=#2c313b guifg=#737373 ctermbg=4 ctermfg=0
" Brighten the line number
"highlight LineNr guifg=#737373

" Palenight
"set background=dark
"let g:airline_theme = "palenight"

" Tokyo
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:airline_theme = "tokyonight"
let g:tokyonight_menu_selection_background = 'blue'

colorscheme tokyonight


" == NERDTree ==
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^.git$']
let g:NERDTreeStatusline = ''
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize = 60
" Remap open keys
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
" Close tree view when open file
let g:NERDTreeQuitOnOpen = 1
" Toggle
nnoremap <silent> <C-b> :NERDTreeFind<CR>
" Automatically close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" == Terminal ==
" open new split panes to the right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
    split term://fish
    resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" == FZF fuzzy finder ==
nnoremap <leader><leader> :Commands<CR>
nnoremap <C-p> :Files<CR>
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \}
" Use fd - does not include ignored by git files
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden -E .git'
" Map ctrl + f to ripgrep across project
nnoremap <C-f> :RG<CR>
" Below function taken from fzf.vim readme, it will invoke rg on each change
" when performing search
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s; or true'
  "let command_fmt = 'rg  -- . || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Open previous buffers
nnoremap <leader>; :Buffers<CR>

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
" == Git gutter ==
" Enable highlights of line numbers on start up
autocmd VimEnter * :GitGutterLineNrHighlightsEnable
nnoremap <leader>g :GitGutterPreviewHunk<CR>
nnoremap <leader>uh :GitGutterUndoHunk<CR>

" == Autosave ==
" Enable auto save
let g:auto_save = 1

"== Vim Sneak ==
" Remap command
map ]s <Plug>Sneak_s
map [s <Plug>Sneak_S
" Add label mode
let g:sneak#label = 1
let g:sneak#s_next = 1

" == Airline ==
" Add ALE to status line
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" == CoC ==

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Use <C-j> and <C-k> to navigate the completion list. This keeps it
" consistent with fzf
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" == Fugitive ==
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" == ALE ==
" Fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'kotlin': ['ktlint']
\}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
" Then remove all other times to perform lint (auto save means insert leave
" and save are the same)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
" Map diagnostics
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" == Vim Workspace ==
" If open a specific file do not try open a workspace
let g:workspace_session_disable_on_args = 1
nnoremap <leader>qw :CloseHiddenBuffers<CR>

