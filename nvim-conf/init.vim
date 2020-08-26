call plug#begin("~/.vim/plugged")
    " Plugin Section
    " ==============
    Plug 'ayu-theme/ayu-vim'
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
    Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" Config Section
" =============
set number relativenumber
syntax on
set tabstop=4
set softtabstop=4
set smarttab
" Indentation amount for < and > commands
set shiftwidth=4
" Insert spaces when tab is pressed
set expandtab
" Copy indent from current line when start new line
set autoindent
set smartindent
" Highlight curosr line
set cursorline

set nowrap

set termguicolors
" Do not show the last command
set noshowcmd
" Yank and paste with the system clipboard
set clipboard=unnamed
" Turn off search highlights when entering insert
nnoremap i :noh<CR>i
" Trim trailing white space on save
autocmd BufWritePre * %s/\s\+$//e
" Wrap markdown files to 80 column
au BufRead,BufNewFile *.md setlocal textwidth=80
" Set spell check in markdown files
autocmd BufRead,BufNewFile *.md setlocal spell
" Show tabs and trailing whitespace
set list listchars=tab:>-,trail:.,extends:>
" Use hidden to keep things like undo history present when change buffer
set hidden
" Map the leader key
let mapleader = " "
" Improve search in file (similar to other editors)
set ignorecase
set smartcase


" Syntax theme
let ayucolor="mirage"
colorscheme ayu

" Color cursorline a little more grey than theme
hi CursorLine cterm=NONE guibg=#2c313b guifg=NONE

" == NERDTree ==
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^.git$']
let g:NERDTreeStatusline = ''
let g:NERDTreeWinPos = "right"
" Remap open keys
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
" Close tree view when open file
let g:NERDTreeQuitOnOpen = 1
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
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
nnoremap <C-p> :Files<CR>
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-s': 'split',
	\ 'ctrl-v': 'vsplit'
	\}
" Use fd - does not include ignored by git files
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden -E .git'
" Map ctrl + f to ripgrep across project and start with previous search
nnoremap <C-f> :RG<CR><C-P>
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
nnoremap ; :Buffers<CR>

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Place the window in the centre of the screen
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
" == Git gutter ==
" Enable highlights of line numbers on start up
autocmd VimEnter * :GitGutterLineNrHighlightsEnable

" == Autosave ==
" Enable auto save
let g:auto_save = 1

" == NerdCommenter ==
" Remap toggle command
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
filetype plugin on

"== Vim Sneak ==
" Remap command
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" == Airline ==
" Set theme
let g:airline_theme='simple'

" == Sneak ==
" Add label mode
let g:sneak#label = 1
let g:sneak#s_next = 1

" == CoC ==
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

" == Fugitive ==
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
