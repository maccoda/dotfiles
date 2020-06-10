call plug#begin("~/.vim/plugged")
    " Plugin Section
    Plug 'ayu-theme/ayu-vim'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    Plug '907th/vim-auto-save'
    Plug 'preservim/nerdcommenter'
    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-fugitive'
    Plug 'dag/vim-fish'
call plug#end()

"Config Section
set number
syntax on
set tabstop=4
" Indentation amount for < and > commands
set shiftwidth=4
" Insert spaces when tab is pressed
set expandtab
set termguicolors
" Do not show the last command
set noshowcmd
" Yank and paste with the system clipboard
set clipboard=unnamed

" Syntax theme
let ayucolor="mirage"
colorscheme ayu

" == NERDTree ==
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeWinPos = "right"
" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()
" Automatically close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open tree on start up and return to editor window
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p

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
let $FZF_DEFAULT_COMMAND = 'fd --type f'
" Map ctrl + f to ripgrep across project
nnoremap <C-f> :RG<CR>
" Below function taken from fzf.vim readme, it will invoke rg on each change
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

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
