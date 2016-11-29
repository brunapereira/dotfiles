" Basic Settings {{{
execute pathogen#infect()
filetype plugin on
colorscheme hybrid_material
syntax on
let mapleader = ","
set nocompatible
set shiftwidth=2
set tabstop=2
set expandtab
set cursorline
set showmatch
set wildmenu
set number
set laststatus=2
set smartindent
set runtimepath^=~/.vim/bundle/ctrlp.vim
set hidden
set smartcase
set hlsearch
set incsearch
set scrolloff=8
set gdefault
set history=1000
set undolevels=1000
set wildignore=*.swp
set visualbell
set noerrorbells " disable sound
set splitright " open file on the right
set splitbelow " open file below

" }}}

" Folding {{{
set foldenable
set foldlevelstart=0
set foldnestmax=10
set foldmethod=marker
set modelines=1
nnoremap <space> za
" }}}

" Ctrl P {{{
let g:ctrlp_user_command = 'find %s -type f | grep -v "`cat ~/.ctrlpignore`"'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" }}}

" dotfiles config shortcuts {{{
nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ez :vsp ~/.zshrc<CR>

" open vim cheatsheet
nmap <silent> <leader>vcs :lefta vsp ~/dotfiles/.vimcheatsheet<cr>:vertical resize -50 <CR>

" }}}

" Arrows {{{
nnoremap j gj
nnoremap k gk

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" }}}

" Tab {{{
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap td :tabclose<CR>
nnoremap tn :tabnew<CR>
" }}}

" NerdTree {{{
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>

"open nerdTree when vim is opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" }}}

" MaximizerToggle {{{
nnoremap <silent><Leader>- :MaximizerToggle<CR>
" }}}

inoremap jj <ESC>
inoremap kk <ESC>
inoremap jk <ESC>

nnoremap <tab> %
vnoremap <tab> %

nnoremap ; :

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR> "removes trailing spaces

nnoremap <silent> <leader>d "_d "deletes without cut
vnoremap <silent> <leader>d "_d "deletes without cut

nmap <silent> <Leader>/ :noh<CR>

let g:jsx_ext_required = 0

" Legacy helpers {{{ 
"
" run perl tests inside vagrant
map <Leader>p :!make unit-test path=% <CR>

"}}}

" Helper to open files/tests {{{
function! Edit(file)
  :execute 'edit' a:file
endfunction
function! SplitVertically()
  :vsplit
endfunction
function! SplitHorizontally()
  :split
endfunction

function! OpenTest()
    if (&ft == 'perl')
      :call Edit(substitute(substitute(expand('%'), 'apps\/lib\/perl_mvc', 't\/unit', 'g'), '\.pm', '.t', 'g'))
    endif
endfunction
function! OpenFile()
    if (&ft == 'perl')
      :call Edit(substitute(substitute(expand('%'), 't\/unit', 'apps\/lib\/perl_mvc', 'g'), '\.t', '.pm', 'g'))
    endif
endfunction

map <Leader>t :call SplitVertically()<CR><C-w>l:call OpenTest()<CR>
map <Leader>it :call SplitHorizontally()<CR><C-w>l:call OpenTest()<CR>

map <Leader>f :call SplitVertically()<CR><C-w>l:call OpenFile()<CR>
map <Leader>if :call SplitHorizontally()<CR><C-w>l:call OpenFile()<CR>

" }}}
