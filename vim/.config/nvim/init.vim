" Zach Schuermann neovim configuration
"
" todos: 
" - https://www.reddit.com/r/neovim/comments/q35328/commentnvim_simple_and_powerful_comment_plugin/
" - https://www.reddit.com/r/neovim/comments/q1z0qf/psa_neovims_builtin_lsp_client_is_now/
" - [ ] Fix automatic install of vim.plug - should track it in dotfiles repo
" - [x] need commentary for comments
" - [x] surround
" - [ ] https://github.com/karb94/neoscroll.nvim
" - [ ] fix highlighted text: make it normal
" - [ ] for some reason lsp not running until first save
" - [ ] for some reason lsp stops with multiple tabs sometimes
" - [ ] better clipboard support
" - [ ] difference between diagnostics/LSP stuff? LSP is diagnostics provider?
" - [ ] trouble/quickfix
" - [ ] better tabline
" - [ ] completion in command-mode
" - [ ] use lightspeed or similar
" - [ ] clean up color scheme (for gruvbox-community one and pare down)
" - [ ] add <leader>w for window management
"   https://stackoverflow.com/questions/15583346/how-can-i-temporarily-make-the-window-im-working-on-to-be-fullscreen-in-vim
" - [ ] fix spellcheck (:help spell)
"   https://github.com/j-hui/pokerus/blob/main/vim/.vim/autoload/spelling.vim
" - [ ] vim useful as mergetool
" - [ ] vim useful as debugger
" - [ ] fix markdown highlighting
" - [ ] make some of my own plugins for tracking at work, etc.
"
" Credit:
" https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
" https://github.com/j-hui/pokerus
"
" Notes: consult help.
" :help quickref

" Bash not fish
set shell=bash

" leader is spacebar
let mapleader ="\<Space>"
let g:mapleader ="\<Space>"

set nocompatible
filetype off
set termguicolors
set number

set mouse=a
set ttyfast
set nofoldenable

" wrap text and comments using textwidth
set formatoptions=tc
" continue comments when pressing ENTER in I mode
set formatoptions+=r
" enable formatting of comments with gq
set formatoptions+=q
" detect lists for formatting
set formatoptions+=n
" auto-wrap in insert mode, and do not wrap old long lines
" set formatoptions+=b

" Search results centered
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Permanent undo
set undodir=~/.vimdid
set undofile

" highlight the cursor line
set cursorline
" single-line scrolling is less jumpy
" TODO revisit scrolling
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
" Sane splits
set splitright
set splitbelow
" Allow buffers to be hidden if you've modified a buffer
set hidden

" FIXME
autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_sign_column="bg0"

call plug#begin('~/.vim/plugged')

Plug 'schuermannator/gruvbox'

" Plug 'crispgm/nvim-tabline'
Plug 'ap/vim-buftabline'            " Tab bar at top
    let g:buftabline_indicators = 1 " Show whether modified
    let g:buftabline_numbers    = 1 " Show buffer numbers
Plug 'b3nj5m1n/kommentary'
Plug 'blackcauldron7/surround.nvim'

" fuzzy finding
Plug 'ibhagwan/fzf-lua'
Plug 'vijaymarupudi/nvim-fzf'

" gitsigns (requires plenary)
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim'

" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'NTBBloodbath/galaxyline.nvim' , {'branch': 'main'}
Plug 'folke/which-key.nvim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'
" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Plug 'scalameta/nvim-metals'

call plug#end()

filetype plugin indent on
set autoindent
set encoding=utf-8
set scrolloff=2
set noshowmode
set lazyredraw

set incsearch
set ignorecase
set smartcase
set gdefault

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

lua << EOF
  -- require('tabline').setup({})
  require("which-key").setup {}
  require'galaxy'
  require('gitsigns').setup {
    keymaps = {
      noremap = false
    }
  }
  -- try out 'sandwich'
  require"surround".setup {mappings_style = "surround"}
  vim.diagnostic.config({severity_sort = true})
EOF

" Completion: {{{
" Better display for messages
set cmdheight=1

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menu,menuone,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" LSP configuration
lua << END
local cmp = require'cmp'
local lspconfig = require'lspconfig'
local lsp_status = require'lsp-status'

-- use LSP SymbolKinds themselves as the kind labels
-- local kind_labels_mt = {__index = function(_, k) return k end}
-- local kind_labels = {}
-- setmetatable(kind_labels, kind_labels_mt)
lsp_status.register_progress()
lsp_status.config({
    -- kind_labels = kind_labels,
    current_function = false,
    indicator_errors = "×",
    indicator_warnings = "•",
    indicator_info = "i",
    indicator_hint = "›",
    indicator_ok = "OK",
    -- the default is a wide codepoint which breaks absolute and relative
    -- line counts if placed before airline's Z section
    status_symbol = "",
})

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- <CR> or <C-f> immediately completes. C-j/C-k to select.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-f>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" })
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   })
-- })

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- lsp status
  lsp_status.on_attach(client, bufnr)

  --Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      -- border = "none"
    },
  })
end


local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Set default client capabilities plus window/workDoneProgress
capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
	      postfix = {
	        enable = false,
	      },
      },
    },
  },
  capabilities = capabilities,
}

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )
END

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '» ', only_current_line = true }
" Enable type inlay hints
" autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
"     \ lua require'lsp_extensions'.inlay_hints{ prefix = '» ', highlight = "Comment" }

" change the E/W to ×/•/» for error/warning highlights in the gutter
call sign_define("DiagnosticSignError", {"text" : "×", "texthl" : "DiagnosticSignError"})
call sign_define("DiagnosticSignWarn", {"text" : "•", "texthl" : "DiagnosticSignWarn"})
call sign_define("DiagnosticSignHint", {"text" : "›", "texthl" : "DiagnosticSignHint"})

" fix left/right shifting when errors are present/absent
" set signcolumn=number ?
set signcolumn=yes

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
" let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=150
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})

" }}}

" Scala (Metals): {{{
" if has('nvim-0.5')
"   set shortmess-=F
"   augroup lsp
"     au!
"     au FileType scala,sbt lua require('metals').initialize_or_attach({})
"   augroup end
" endif
" }}}

" FZF keys
nnoremap <leader>. <cmd>lua require('fzf-lua').git_files()<CR>
nnoremap <leader>, <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <leader>f <cmd>lua require('fzf-lua').builtin()<CR>
nnoremap <leader>n <cmd>lua require('fzf-lua').blines()<CR>
nnoremap <leader><leader> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <leader>s <cmd>lua require('fzf-lua').grep_project()<CR>

nnoremap <C-c> <Cmd>nohlsearch<Bar>diffupdate<CR><C-c>
nnoremap <leader>F :RustFmt<CR>

" Jump to start and end of line using the home row keys
map <C-h> ^
map <C-l> $
map <F1> <Esc>
imap <F1> <Esc>

" No arrow keys for the flex
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

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

" vim: set sw=2 ts=2 sts=2 et tw=100 ft=vim fdm=marker:
