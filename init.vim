" Leader mapping {{{
let mapleader = ","
let maplocalleader = ","
" }}}

" Basic Settings {{{
syntax on
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set history=1000
set undolevels=1000
set belloff=all
set splitright
set splitbelow
set encoding=UTF-8
set hidden
set number
nnoremap ; :
" }}}

" Folding {{{
set foldenable
set foldlevelstart=0
set foldnestmax=10
set foldmethod=marker
set modelines=1
nnoremap <space> za
" }}}

" Tab {{{
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap td :tabclose<CR>
nnoremap tn :tabnew<CR>
" }}}

" Leave visual mode when attempting to move cursor {{{
inoremap jj <ESC>
inoremap kk <ESC>
inoremap jk <ESC>
" }}}

" Arrows {{{
nnoremap j gj
nnoremap k gk

" instead of Ctrl + W + arrow, just CTRL + arrow to switch focus
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" }}}

" <leader> + \. clear highlight {{{
map <Leader>/ :nohlsearch<CR>
" }}}

" Find and replace tricks {{{
nnoremap <Leader>R
			\ :let @s='\<'.expand('<cword>').'\>'<CR>
			\ :cfdo %s/<C-r>s// \| update
			\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" }}}

" dotfiles config shortcuts {{{
nmap <silent> <Leader>ev :vsp $MYVIMRC<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ez :vsp ~/.zshrc<CR>
" }}}

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Olical/conjure', { 'tag': 'v4.17.0' } " REPL integration

Plug 'm00qek/nvim-lsp' "Static analysis

" autocomplete
Plug 'nvim-lua/completion-nvim'
" Plug 'm00qek/completion-conjure'

" structural edition
Plug 'guns/vim-sexp', { 'for': 'clojure' } | Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

" Colorscheme
Plug 'morhetz/gruvbox'
Plug 'romainl/Apprentice'

Plug 'axelf4/vim-strip-trailing-whitespace' "Remove trailing space on save
Plug 'luochen1990/rainbow' "Rainbow parentheses
Plug 'preservim/nerdtree' "File tree
Plug 'hashivim/vim-terraform' "Terraform
Plug 'vim-test/vim-test' "Vim test
Plug 'dense-analysis/ale' "Linting
Plug 'preservim/nerdcommenter' "Comments

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive' " Git awesome commands

Plug 'airblade/vim-gitgutter' " Git modified lines

Plug 'szw/vim-maximizer' " Toggle maximize windows

call plug#end()

" }}}

" Colors {{{
colorscheme gruvbox

let g:rainbow_active = 1 "Rainbow parentheses
"}}}

" Terraform {{{
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1
let g:terraform_binary_path="/usr/local/Cellar/terraform/0.14.3/bin/terraform"
" }}}

" Ale {{{
let g:ale_linters = {'clojure': ['clj-kondo']}
" }}}

" Vim test {{{
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
" }}}

" NerdTree {{{
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>
autocmd VimEnter * NERDTree
" }}}

" Nerd Commenter {{{
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" }}}

" GitGutter {{{
autocmd BufWritePost * GitGutter
" }}}

" MaximizerToggle {{{
nnoremap <silent><Leader>- :MaximizerToggle<CR>
" }}}

" Vim cheatsheet {{{
nmap <silent> <leader>vcs :NERDTreeClose<cr>:lefta vsp ~/dotfiles/.vimcheatsheet<cr>:vertical resize -50 <CR>
" }}}

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
    if (&ft == 'clojure')
      :call Edit(substitute(substitute(expand('%'), 'src', 'test\/unit', 'g'), '.clj', '_test.clj', 'g'))
    endif
endfunction
function! OpenFile()
    if (&ft == 'clojure')
      :call Edit(substitute(substitute(expand('%'), 'test\/unit', 'src', 'g'), '_test.clj', '.clj', 'g'))
    endif
endfunction

map <Leader>t :call SplitVertically()<CR><C-w>l:call OpenTest()<CR>
map <Leader>it :call SplitHorizontally()<CR><C-w>l:call OpenTest()<CR>

map <Leader>f :call SplitVertically()<CR><C-w>l:call OpenFile()<CR>
map <Leader>if :call SplitHorizontally()<CR><C-w>l:call OpenFile()<CR>

" }}}

" Clojure specific config {{{

" static analysis config
lua << EOF
local on_attach_vim = function(client, bufnr)
  require'completion'.on_attach()
end

local ok, lsp = pcall(require,"nvim_lsp")
if ok then
  lsp.clojure_lsp.setup{on_attach=on_attach_vim}
end
EOF

" use <local leader> K to get docstring trough REPL connection
" let g:conjure#mapping#doc_word = "K"

" use K to get docstring trough static analysis
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

" use gd to jump to definition trough REPL connection
" let g:conjure#mapping#def_word = ["gd"]

" use C-] to jump to definition trough static analysis
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>

" other LSP mappings
" please refer to `:help lsp` for a complete list
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gA <cmd>lua vim.lsp.buf.code_action()<CR>

" use static analysis engine to autocomplete, but get results also from REPL if
" it is available
let g:completion_auto_change_source = 1
let g:completion_chain_complete_list = {
\ 'clojure': [
\   {'complete_items': ['conjure', 'lsp', 'snippet']}
\ ]
\}

" set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" avoid showing message extra message when using completion
set shortmess+=c

" }}}
