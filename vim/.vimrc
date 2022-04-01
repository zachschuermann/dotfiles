" Zach Schuermann's vim config - see 'init.vim' for neovim-specific additions
" -----------------------------------------------------------------------------
" File: .vimrc
" Description: Zach Schuermann's (n)vim configuration
" Author: Zach Schuermann <zachary.schuermann@gmail.com>
" Source: https://github.com/schuermannator/dotfiles
" Last Modified: 18 Mar 2021
" -----------------------------------------------------------------------------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Basic Settings ---------------------------------------------------------
" General Settings: {{{

"use `if !has('nvim')` to do vim-specific things, put nvim stuff in `init.vim`

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" turn on syntax
" syntax on => moved to 'COLORS'

" Enable filetype plugins
filetype plugin on
filetype plugin indent on

" status bar laststatus=2 is always on
set laststatus=2

" sane defaults
set ruler
set number
" set relativenumber
set number
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set nocindent
" highlight the cursor line
set cursorline
" single-line scrolling is less jumpy
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
" Sane splits
set splitright
set splitbelow
" Allow buffers to be hidden if you've modified a buffer
set hidden
" Sets how many lines of history VIM has to remember
set history=1000
"" trying these out
set nowrap
set nojoinspaces
set incsearch
" lets me type :plugi<tab> => :PlugInstall
set ignorecase
set smartcase
""

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Permanent undo
set undodir=~/.vimdid
set undofile

" Backup
set backupdir=~/.vimbackup
set backup

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
" :augroup vimStartup | au! | augroup END
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

" }}}
" Indentation: {{{

autocmd FileType markdown setlocal textwidth=100
autocmd FileType tex      setlocal textwidth=100

" """
" " C
" """
" autocmd BufNewFile,BufReadPost *.c set filetype=c
" autocmd BufNewFile,BufReadPost *.h set filetype=c
" autocmd FileType c setlocal
"             \ tabstop=4
"             \ expandtab
"             \ shiftwidth=4
"             \ softtabstop=4
" 
" """
" " C++
" """
" autocmd BufNewFile,BufReadPost *.cpp set filetype=cpp
" autocmd FileType cpp setlocal
"             \ tabstop=4
"             \ expandtab
"             \ shiftwidth=4
"             \ softtabstop=4
" 
" 
" """"""""""
" " Makefile
" """"""""""
autocmd FileType make setlocal noexpandtab
" 
" """"""""""
" " Markdown
" """"""""""
" autocmd Filetype markdown setlocal
"             \ tabstop=4
"             \ expandtab
"             \ shiftwidth=4
"             \ softtabstop=4
"             \ textwidth=112
" 
" """"""""""
" " Text
" """"""""""
" autocmd FileType text setlocal autoindent expandtab softtabstop=2 textwidth=100
" 
" """"""""""
" " Python
" """""""""""
" autocmd FileType python setlocal
"             \ tabstop=4
"             \ expandtab
"             \ shiftwidth=4
"             \ softtabstop=4
" 
" """"""""""
" " go 
" """""""""""
" autocmd FileType go setlocal
"             \ tabstop=2
"             \ expandtab
"             \ shiftwidth=2
"             \ softtabstop=2
" 
" """"""""""
" " Haskell
" """""""""""
" autocmd FileType haskell setlocal
"             \ tabstop=4
"             \ expandtab
"             \ shiftwidth=4
"             \ softtabstop=4

" }}}
" Colors: {{{

autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_sign_column="bg0"

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"autocmd BufEnter * colorscheme default
"autocmd BufEnter *.hs colorscheme spacecamp

" Enable all py highlighting
let g:python_highlight_all=1
let g:indentLine_color_term=8
let g:indentLine_char = '▏'

" Enable all Haskell highlighting features
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Go highlighting
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highligh_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1

" }}}
" GUI: {{{
" it's the 21st century, turn on mouse support
set mouse=a
set ttyfast
set nofoldenable

" deal with colors
" if !has('gui_running')
"     set t_Co=256
" endif

" TODO idk man need to figure out colors
" used to have this added below: (annoying with tmux so removed)
" && (match($TERM, "screen-256color") == -1)
" if (match($TERM, "-256color") != -1)
"     " screen does not (yet) support truecolor
"     set termguicolors
" endif
set termguicolors
" }}}
" Fonts: {{{
" Show annoying hidden characters
set listchars=nbsp:¬,extends:»,precedes:«,trail:•
set guifont=Monospace\ 12
" }}}
" Editing: {{{
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

" nnoremap <silent> <Tab> za
" }}}

" Plugins ---------------------------------------------------------
" Plugins: {{{

call plug#begin('~/.vim/plugged')

Plug 'schuermannator/gruvbox'
"Plug 'simnalamburt/vim-mundo'
Plug 'neovimhaskell/haskell-vim'
"Plug 'ziglang/zig.vim'

if has('nvim')
    " Collection of common configurations for the Nvim LSP client
    Plug 'neovim/nvim-lspconfig'
    
    " Extensions to built-in LSP, for example, providing type inlay hints
    Plug 'tjdevries/lsp_extensions.nvim'
    
    " Autocompletion framework for built-in LSP
    "Plug 'nvim-lua/completion-nvim'
    Plug 'hrsh7th/nvim-compe'
    Plug 'hrsh7th/vim-vsnip'
    
    " Diagnostic navigation and settings for built-in LSP
    " Plug 'nvim-lua/diagnostic-nvim' DEPRECATED

    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " gitsigns requires plenary
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'scalameta/nvim-metals'

    Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
    Plug 'folke/which-key.nvim'
end

" Metals
set shortmess-=F
augroup lsp
    au!
    au FileType scala,sbt lua require("metals").initialize_or_attach({})
  augroup end

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
" ## LIGHTLINE
" -------------------------------------

" Plug 'itchyny/lightline.vim'        " Lightweight status line at bottom
"     let g:lightline = {
"         \ 'colorscheme': 'PaperColor',
"         \ 'active': {
"         \   'left': [
"         \       [ 'mode', 'paste' ],
"         \       [ 'gitbranch', 'readonly', 'relativepath', 'modified' ],
"         \   ],
"         \   'right': [
"         \       [ 'lineinfo' ],
"         \       [ 'percent' ],
"         \       [ 'scrollbar'],
"         \       [ 'lsp_status', 'fileformat', 'fileencoding', 'filetype' ],
"         \   ],
"         \ },
"         \ 'component_expand': {
"         \   'lsp_status': 'LspStatus'
"         \ },
"     \ }

" don't show mode since we show in lightline now
set noshowmode

" au User LspDiagnosticsChanged call lightline#update()
" au User LspMessageUpdate  call lightline#update()
" au User LspStatusUpdate  call lightline#update()
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

" TODO check nocolor speed
" let g:fzf_layout = { 'down': '~30%' }
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=never '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

" leader-. does FZF for git files
" leader-, does FZF for buffers
" keybinds done below under KEYBINDS

" -------------------------------------
" ## RIPGREP
" -------------------------------------
" if executable('rg')
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m
" endif

" -------------------------------------
" ## NERDTREE - deprecated
" -------------------------------------
" show hidden files by default
" let g:NERDTreeShowHidden=1
" open and close file tree
" map <C-n> :NERDTreeToggle<CR>
" open current buffer in file tree
" nmap <leader>n :NERDTreeFind<CR>


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
"Plug 'JuliaEditorSupport/julia-vim'
call plug#end()
" }}}
" Completion: {{{
" =============================================================================
" see: https://sharksforarms.dev/posts/neovim-rust/ -- kinda deprecated - doing stuff differently
" NEOVIM ONLY
" =============================================================================
" }}}
" Keybinds: {{{
" note plugin-specific keybinds are above with the plugin configs
" and completion keybinds are above with completion configs
" leader is spacebar (assigned at top)

" don't need F1 help. F1 --> esc
map <F1> <Esc>
imap <F1> <Esc>

" ctrl-g is just esc
" nnoremap <C-g> <Esc>
" inoremap <C-g> <Esc>
" vnoremap <C-g> <Esc>
" snoremap <C-g> <Esc>
" xnoremap <C-g> <Esc>
" cnoremap <C-g> <Esc>
" onoremap <C-g> <Esc>
" lnoremap <C-g> <Esc>
" tnoremap <C-g> <Esc>

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

" FZF/telescope (TODO) bindings
nnoremap <leader>n :Lines<CR>
" leader-. does FZF for git files
" leader-, does FZF for buffers
nnoremap <leader>. :GFiles<CR>
nnoremap <leader>, :Buffers<CR>
" leader-leader does FZF for files in current folder
nnoremap <leader><leader> :Files<CR>

" Find files using Telescope command-line sugar.
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>ff <cmd>Telescope lsp_references<cr>
nnoremap <leader>fa <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>

" vim-mundo
" nnoremap <leader>u :MundoToggle<CR>

" <leader>s for Rg search
nnoremap <leader>s :Rg<CR>

" Formatting is <leader>-f
" RustFmt/GoFmt is space-f
" nnoremap <leader>f :RustFmt<CR>
" autocmd FileType rust nnoremap <buffer> <leader>f :RustFmt<CR>

" hacky, see: https://vi.stackexchange.com/questions/10664/file-type-dependent-key-mapping
autocmd FileType rust     nnoremap <buffer> <leader>F :RustFmt<CR>
autocmd FileType go       nnoremap <buffer> <leader>F :call LanguageClient#textDocument_formatting_sync()<CR>
autocmd FileType markdown nnoremap <buffer> <leader>F gqap
autocmd FileType tex      nnoremap <buffer> <leader>F gqap

" leader-e
" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

""" Buffer Management 

" Move to the next buffer
nnoremap <leader>l :bnext<CR>
" Move to the previous buffer
nnoremap <leader>h :bprevious<CR>

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

" }}}
" Misc: {{{

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

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=100 ft=vim fdm=marker:
