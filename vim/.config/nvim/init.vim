" Zach Schuermann neovim-specific vimconfig

" first, make sure we load .vimrc
" get shared vim/nvim packages (in Vim's normal runtime path)
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" pull shared config (.vimrc)
source ~/.vimrc


lua << EOF
  require("which-key").setup {}
EOF

" nvim-treesitter: {{{
" using for everything except rust - doesnt parse 'mut', 'static', etc.
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  highlight = {
    enable = true,            -- false will disable the whole extension
    disable = { "rust" },     -- list of language that will be disabled
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["mut"] = "TSTypeBuiltin",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}

require'galaxy'
EOF
" }}}
" Completion: {{{
" see: https://sharksforarms.dev/posts/neovim-rust/

" Better display for messages
set cmdheight=1

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:false
let g:compe.source.treesitter = v:true
let g:compe.source.omni = v:false

inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

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
    current_function = false,
    indicator_errors = "×",
    indicator_warnings = "!",
    indicator_info = "i",
    indicator_hint = "›",
    indicator_ok = "OK",
    -- the default is a wide codepoint which breaks absolute and relative
    -- line counts if placed before airline's Z section
    status_symbol = "",
})

-- Set default client capabilities plus window/workDoneProgress
-- config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client, bufnr)
    -- require'completion'.on_attach(client, bufnr)
    lsp_status.on_attach(client, bufnr)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    capabilities = capabilities,
})

-- Enable gopls
nvim_lsp.gopls.setup({
    on_attach=on_attach,
    capabilities = lsp_status.capabilities
})

EOF

lua <<EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        -- To disable a keymap, put [map] = false
        -- So, to not map "<C-n>", just put
        -- ["<c-x>"] = false,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      -- n = {
        -- ["<esc>"] = actions.close,
        -- ["<C-i>"] = my_cool_custom_action,
      -- },
    },
  }
}
require('gitsigns').setup()
EOF

" Statusline
" function! LspStatus() abort
"   if luaeval('#vim.lsp.buf_get_clients() > 0')
"     return luaeval("require('lsp-status').status()")
"   endif
" 
"   return ''
" endfunction

" change the E/W to ×/• for error/warning highlights in the gutter
call sign_define("LspDiagnosticsSignError", {"text" : "×", "texthl" : "LspDiagnosticsSignError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "•", "texthl" : "LspDiagnosticsSignWarning"})
call sign_define("LspDiagnosticsSignHint", {"text" : "»", "texthl" : "LspDiagnosticsSignHint"})
" ›
" Trigger completion with <Tab>
" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ completion#trigger_completion()

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
" airline - DEPRECATED - (using lightline/tabline instead): {{{
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

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=100 ft=vim fdm=marker:
