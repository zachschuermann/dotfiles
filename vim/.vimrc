" Zach Schuermann vimconfig - see 'init.vim' for neovim-specific additions
" =============================================================================
" # BASIC SETTINGS
" =============================================================================

"use `if !has('nvim')` to do vim-specific things, put nvim stuff in `init.vim`

" turn on syntax
syntax on

" Enable filetype plugins
filetype plugin on
filetype plugin indent on

" status bar laststatus=2 is always on
set laststatus=2

" sane defaults
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set nocindent
" Sane splits
set splitright
set splitbelow
" Sets how many lines of history VIM has to remember
set history=1000
"" trying these out
set nowrap
set nojoinspaces
""

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
" look into this later
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Fish doesn't play all that well with others
set shell=/bin/bash

" leader is spacebar
let mapleader ="\<Space>"
let g:maplxeader ="\<Space>"

" =============================================================================
" # COLORS
" =============================================================================
"colorscheme base16-gruvbox-dark-medium
color dracula
"autocmd BufEnter * colorscheme default
"autocmd BufEnter *.hs colorscheme spacecamp
highlight CursorLineNr guifg=#6272a4
" =============================================================================
" # GUI
" =============================================================================
" its the 21st century, turn on mouse support
set mouse=a
set ttyfast
set nofoldenable

" deal with colors
if !has('gui_running')
    set t_Co=256
endif

" TODO idk man need to figure out colors
" used to have this added below: (annoying with tmux so removed)
" && (match($TERM, "screen-256color") == -1)
if (match($TERM, "-256color") != -1)
    " screen does not (yet) support truecolor
    set termguicolors
endif

" =============================================================================
" # FONTS/CHARS
" =============================================================================
" Show annoying hidden characters
set listchars=nbsp:¬,extends:»,precedes:«,trail:•
set guifont=Monospace\ 12

" =============================================================================
" # EDITING
" =============================================================================
" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Search results centered
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" =============================================================================
" # PLUGINS
" =============================================================================

" -------------------------------------
" ## AIRLINE
" -------------------------------------
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" -------------------------------------
" ## FZF
" -------------------------------------
" If installed using Homebrew
" need to make this more portable
set rtp+=/usr/local/opt/fzf
set rtp+=/usr/bin/fzf

" FZF + rg = <3
let g:fzf_layout = { 'down': '~30%' }
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

" leader-. does FZF for git files
" leader-, does FZF for buffers
" keybinds done below under KEYBINDS > BUFFER MANAGEMENT

" -------------------------------------
" ## RIPGREP
" -------------------------------------
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" <leader>s for Rg search
nnoremap <leader>s :Rg<CR>

" -------------------------------------
" ## NERDTREE
" -------------------------------------
" show hidden files by default
let g:NERDTreeShowHidden=1
" open and close file tree
map <C-n> :NERDTreeToggle<CR>
" open current buffer in file tree
nmap <leader>n :NERDTreeFind<CR>

" =============================================================================
" # COMPLETION
" =============================================================================
" see: https://sharksforarms.dev/posts/neovim-rust/
" NEOVIM ONLY

" =============================================================================
" # KEYBINDS
" =============================================================================
" note plugin-specific keybinds are above with the plugin configs
" and completion keybinds are above with completion configs
" leader is spacebar (assigned at top)

" don't need F1 help. F1 --> esc
map <F1> <Esc>
imap <F1> <Esc>

" ctrl-g is just esc
nnoremap <C-g> <Esc>
inoremap <C-g> <Esc>
vnoremap <C-g> <Esc>
snoremap <C-g> <Esc>
xnoremap <C-g> <Esc>
cnoremap <C-g> <Esc>
onoremap <C-g> <Esc>
lnoremap <C-g> <Esc>
tnoremap <C-g> <Esc>
" No arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" ctrl-h/ctrl-l go to start/end of line
map <C-h> ^
map <C-l> $

" RustFmt is space-f
nnoremap <leader>f :RustFmt<CR>

" leader-e
" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" -------------------------------------
" ## BUFFER MANAGEMENT
" -------------------------------------
set hidden " Allow buffers to be hidden if you've modified a buffer

" leader-leader toggels between buffers
nnoremap <leader><leader> <c-^>

" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" leader-q: Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>q :bp <BAR> bd #<CR>

" leader-bl (buffer-list):
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" leader-b shows stats
nnoremap <leader>b g<c-g>

" left/right arrows cycle buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" leader-. does FZF for git files
" leader-, does FZF for buffers
nnoremap <leader>. :GFiles<CR>
nnoremap <leader>, :Buffers<CR>

" =============================================================================
" # MISC
" =============================================================================

" Golang path stuff
let g:go_bin_path = expand("~/dev/go/bin")

""" Try these out?
" Leave paste mode when leaving insert mode
" autocmd InsertLeave * set nopaste
" (unused) Set to auto read when a file is changed from the outside
" set autoread
