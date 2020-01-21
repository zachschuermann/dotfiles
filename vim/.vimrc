syntax on

set laststatus=2
set number
set expandtab
set tabstop=4
set shiftwidth=4
" colorscheme peachpuff
color dracula

set autoindent
set nocindent

set guifont=Monospace\ 12

set autoindent
set nocindent

" set guioptions-=T  " remove menu bar

" keybindings
"noremap \f :FSHere<CR>
"noremap \t :tabnew<CR>
"noremap \v :vs<CR>
"noremap \s :sp<CR>
"noremap \a :tabprevious<CR>
"noremap \d :tabnext<CR>
"noremap \q :q<CR>
"noremap \Q :bd<CR>
"noremap \m :set mouse=a<CR>
"noremap \M :set mouse=<CR>
"noremap \c :e %<.c<CR>
"noremap \C :e %<.cpp<CR>
"noremap \h :e %<.h<CR>
"
" Sets how many lines of history VIM has to remember
set history=1000

" Enable filetype plugins
filetype plugin on
filetype plugin indent on

" (unused) Set to auto read when a file is changed from the outside
" set autoread                 

let mapleader ="\<Space>"      
let g:mapleader ="\<Space>"    

" Airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename 

" -----------Buffer Management---------------
set hidden " Allow buffers to be hidden if you've modified a buffer

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>q :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Use arrow keys to navigate window splits
nnoremap <silent> <Right> :wincmd l <CR> 
nnoremap <silent> <Left> :wincmd h <CR>
noremap <silent> <Up> :wincmd k <CR>
noremap <silent> <Down> :wincmd j <CR>

" ctrl-p
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git|.svn|.hg|.bzr directory as the cwd
let g:ctrlp_working_path_mode = 'r' 
" enter file search mode
nmap <leader>p :CtrlP<cr>

" Nerdtree
" autocmd vimenter * NERDTree"
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" open and close file tree
map <C-n> :NERDTreeToggle<CR>
" open current buffer in file tree
nmap <leader>n :NERDTreeFind<CR>

