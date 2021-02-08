" Zach Schuermann vimconfig - see 'init.vim' for neovim-specific additions
" =============================================================================
" # BASIC SETTINGS
" =============================================================================

"use `if !has('nvim')` to do vim-specific things, put nvim stuff in `init.vim`

" turn on syntax
" syntax on => moved to 'COLORS'

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
set shell=bash

" leader is spacebar
let mapleader ="\<Space>"
let g:maplxeader ="\<Space>"

" from vim/runtime/defaults.vim
" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

augroup END



" =============================================================================
" # COLORS
" =============================================================================
"colorscheme base16-gruvbox-dark-medium
"color dracula
"autocmd BufEnter * colorscheme default
"autocmd BufEnter *.hs colorscheme spacecamp
"highlight CursorLineNr guifg=#6272a4
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
" if (match($TERM, "-256color") != -1)
"     " screen does not (yet) support truecolor
"     set termguicolors
" endif
set termguicolors

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

call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'neovimhaskell/haskell-vim'

if has('nvim')
    " Collection of common configurations for the Nvim LSP client
    Plug 'neovim/nvim-lspconfig'
    
    " Extensions to built-in LSP, for example, providing type inlay hints
    Plug 'tjdevries/lsp_extensions.nvim'
    
    " Autocompletion framework for built-in LSP
    Plug 'nvim-lua/completion-nvim'
    
    " Diagnostic navigation and settings for built-in LSP
    " Plug 'nvim-lua/diagnostic-nvim' DEPRECATED

    Plug 'nvim-lua/lsp-status.nvim'
end

" Unintrusive * preview
" Plug 'itchyny/vim-cursorword'
"     let g:cursorword_delay = 369
"     let b:cursorword = 1
"     function! ToggleCursorWord()
"         if b:cursorword
"             let b:cursorword = 0
"         else
"             let b:cursorword = 1
"         endif
"     endfunction
"     cnoreabbrev csw call ToggleCursorWord()

" -------------------------------------
" ## ~~AIRLINE~~ LIGHTLINE
" -------------------------------------
" Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1
" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'

Plug 'itchyny/lightline.vim'        " Lightweight status line at bottom
    let g:lightline = {
        \ 'colorscheme': 'PaperColor',
        \ 'active': {
        \   'left': [
        \       [ 'mode', 'paste' ],
        \       [ 'gitbranch', 'readonly', 'relativepath', 'modified' ],
        \   ],
        \   'right': [
        \       [ 'lineinfo' ],
        \       [ 'percent' ],
        \       [ 'scrollbar'],
        \       [ 'lsp_status', 'fileformat', 'fileencoding', 'filetype' ],
        \   ],
        \ },
        \ 'component_expand': {
        \   'lsp_status': 'LspStatus'
        \ },
    \ }

autocmd User LspDiagnosticsChanged call lightline#update()
        "\ 'component': {
        "\   'scrollbar': '%{ScrollStatus()}',
        "\ },
" -------------------------------------
" ## FZF
" -------------------------------------
" If installed using Homebrew
" need to make this more portable
set rtp+=/usr/local/opt/fzf
set rtp+=/usr/bin/fzf

" FZF + rg = <3
"Plug 'junegunn/fzf.vim'                                 " Fuzzy finder
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
    let g:fzf_preview_window = 'right:60%'
    "nnoremap <leader>ff   :Files    <space>
    "nnoremap <leader>fe   :Files    <CR>
    "nnoremap <leader>fg   :GFiles   <CR>
    "nnoremap <leader>fj   :Lines    <CR>
    "nnoremap <leader>fa   :Ag       <CR>
    "nnoremap <leader>fb   :Buffers  <CR>
    "nnoremap <leader>f:   :History: <CR>
    "nnoremap <leader>f/   :History/ <CR>

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


" Plug 'ojroques/vim-scrollstatus'    " Scroll bar on status line
    " let g:scrollstatus_size = 20

Plug 'ap/vim-buftabline'            " Tab bar at top
    let g:buftabline_indicators = 1 " Show whether modified
    let g:buftabline_numbers    = 1 " Show buffer numbers

    nmap <C-w>1 <Plug>BufTabLine.Go(1)
    nmap <C-w>2 <Plug>BufTabLine.Go(2)
    nmap <C-w>3 <Plug>BufTabLine.Go(3)
    nmap <C-w>4 <Plug>BufTabLine.Go(4)
    nmap <C-w>5 <Plug>BufTabLine.Go(5)
    nmap <C-w>6 <Plug>BufTabLine.Go(6)
    nmap <C-w>7 <Plug>BufTabLine.Go(7)
    nmap <C-w>8 <Plug>BufTabLine.Go(8)
    nmap <C-w>9 <Plug>BufTabLine.Go(9)
    nmap <C-w>0 <Plug>BufTabLine.Go(-1)


Plug 'tpope/vim-surround'               " ds, cs, ys to change text surroundings
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
"         let g:markdown_fenced_languages = [
"                     \ 'html',
"                     \ 'python',
"                     \ 'bash=sh',
"                     \ 'c',
"                     \ 'cpp',
"                     \ 'ocaml',
"                     \ 'haskell',
"                     \ 'rust',
"                     \ 'go',
"                     \ 'json=javascript',
"                     \ ]
" Plug 'tpope/vim-markdown',  { 'for': 'markdown' }
"Plug 'jtratner/vim-flavored-markdown', { 'for': 'markdown' }
Plug 'fatih/vim-go',            { 'for': 'go' }
Plug 'rust-lang/rust.vim',      { 'for': 'rust' }
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

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

" Formatting is <leader>-f
" RustFmt/GoFmt is space-f
" TODO add GoFmt
nnoremap <leader>f :RustFmt<CR>

" hacky, see: https://vi.stackexchange.com/questions/10664/file-type-dependent-key-mapping
autocmd FileType rust   nnoremap <buffer> <leader>f :RustFmt<CR>
" autocmd FileType go     nnoremap <buffer> <leader>f :call LanguageClient#textDocument_formatting_sync()<CR>


" leader-e
" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" -------------------------------------
" ## BUFFER MANAGEMENT
" -------------------------------------
set hidden " Allow buffers to be hidden if you've modified a buffer

" leader-leader toggels between buffers DEPRECATED
" nnoremap <leader><leader> <c-^>
" leader-leader does FZF for files in current folder
nnoremap <leader><leader> :Files<CR>

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

" Go setup
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


""" Try these out?
" Leave paste mode when leaving insert mode
" autocmd InsertLeave * set nopaste
" (unused) Set to auto read when a file is changed from the outside
" set autoread


" TODO clipboard integration
" <space>p will paste clipboard into buffer
" <space>c will copy entire buffer into clipboard
"noremap <leader>p :read !xsel --clipboard --output<cr>
"noremap <leader>y :w !xsel -ib<cr><cr>


" let s:bgdarker  = ['', 234]


" set background=dark
" set background=#191A21
let base16colorspace=256
"let g:base16_shell_path="~/dev/others/base16/templates/shell/scripts/"

colorscheme base16-gruvbox-dark-hard
syntax on
hi Normal ctermbg=NONE
set cursorline
" call Base16hi("Comment", g:base16_gui04, "", g:base16_cterm04, "", "", "")
call Base16hi("Comment", "6272A4", "", "6272A4", "", "", "")
call Base16hi("Normal", g:base16_gui07, g:base16_gui00, g:base16_cterm07, g:base16_cterm00, "", "")

call Base16hi("LineNr",        g:base16_gui02, g:base16_gui00, g:base16_cterm02, g:base16_cterm00, "", "")
call Base16hi("SignColumn",    g:base16_gui02, g:base16_gui00, g:base16_cterm02, g:base16_cterm00, "", "")
call Base16hi("CursorLine",    "", "1a1a1a", "", "1a", "", "")
call Base16hi("CursorLineNr",    g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "", "")

autocmd bufreadpre *.md setlocal textwidth=100
