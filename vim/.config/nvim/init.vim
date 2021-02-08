" get shared vim/nvim packages (in Vim's normal runtime path)
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" pull shared config (.vimrc)
source ~/.vimrc

" Zach Schuermann neovim-specific vimconfig
" =============================================================================
" # BASIC SETTINGS
" =============================================================================

" remove the thin cursor on insert mode (leave normal block cursor)
" if has('nvim')
    " set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    " set guicursor=
    " set inccommand=nosplit
" end

" =============================================================================
" # FONTS/CHARS
" =============================================================================

" =============================================================================
" # EDITING
" =============================================================================

" =============================================================================
" # PLUGINS
" =============================================================================

" -------------------------------------
" ## AIRLINE - DEPRECATED (using lightline/tabline instead)
" -------------------------------------
" Below is set in .vimrc
" Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1
" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'
" end below

" Statusline
" function! LspStatus() abort
"   if luaeval('#vim.lsp.buf_get_clients() > 0')
"     return luaeval("require('lsp-status').status()")
"   endif
"
"   return ''
" endfunction
" function! LspStatus() abort
"     let status = luaeval('require("lsp-status").status()')
"     return trim(status)
" endfunction
" autocmd VimEnter * call airline#parts#define_function('lsp_status', 'LspStatus')
" autocmd VimEnter * call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 0")')

" DEPRECATED powerline-fonts - idk don't need it and it just introduces gray
" box next to mode indicator on the far left
" let g:airline_powerline_fonts = 1

" let g:airline#extensions#nvimlsp#enabled = 1
" autocmd VimEnter * let g:airline_section = airline#section#create_right(['lsp_status'])

" -------------------------------------
" ## NVIM-LSPCONFIG
" -------------------------------------
" DEPRECATED: moved below under completion
" lua <<EOF
" vim.cmd('packadd nvim-lspconfig')  -- If installed as a Vim package.
" require'nvim_lsp'.rust_analyzer.setup{}
" EOF

" =============================================================================
" # COMPLETION
" =============================================================================
" see: https://sharksforarms.dev/posts/neovim-rust/

" Better display for messages
set cmdheight=2

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
-- vim.cmd('packadd nvim-lspconfig')  -- installed as a Vim "package".
-- vim.cmd('packadd lsp-status.nvim')  -- installed as a Vim "package".

local nvim_lsp = require'lspconfig'
local lsp_status = require'lsp-status'


-- use LSP SymbolKinds themselves as the kind labels
local kind_labels_mt = {__index = function(_, k) return k end}
local kind_labels = {}
setmetatable(kind_labels, kind_labels_mt)

-- Register the progress callback
lsp_status.register_progress()
lsp_status.config({
    kind_labels = kind_labels,
    indicator_errors = "×",
    indicator_warnings = "!",
    indicator_info = "i",
    indicator_hint = "›",
    -- the default is a wide codepoint which breaks absolute and relative
    -- line counts if placed before airline's Z section
    status_symbol = "",
})

-- Set default client capabilities plus window/workDoneProgress
-- config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client, bufnr)
    require'completion'.on_attach(client, bufnr)
    lsp_status.on_attach(client, bufnr)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    capabilities = lsp_status.capabilities
})

-- Enable gopls
nvim_lsp.gopls.setup({
    on_attach=on_attach,
    capabilities = lsp_status.capabilities
})

EOF

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

" change the E/W to ×/• for error/warning highlights in the gutter
call sign_define("LspDiagnosticsSignError", {"text" : "×", "texthl" : "LspDiagnosticsSignError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "•", "texthl" : "LspDiagnosticsSignWarning"})
call sign_define("LspDiagnosticsSignHint", {"text" : "»", "texthl" : "LspDiagnosticsSignHint"})
" ›
" Trigger completion with <Tab>
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ completion#trigger_completion()

" Use `C-j` and `C-k` to navigate diagnostics
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" fix left/right shifting when errors are present/absent
" TODO update to signcolumn=number after update?
set signcolumn=yes

" Code navigation shortcuts
nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<CR>

" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
" nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
" nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
    \ lua require'lsp_extensions'.inlay_hints{ prefix = '» ', highlight = "Comment" }

" Use auocmd to force lightline update.
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

""

" =============================================================================
" # KEYBINDS
" =============================================================================
" note plugin-specific keybinds are above with the plugin configs
" and completion keybinds are above with completion configs
" leader is spacebar (assigned at top)

" -------------------------------------
" ## BUFFER MANAGEMENT
" -------------------------------------

" =============================================================================
" # MISC
" =============================================================================
