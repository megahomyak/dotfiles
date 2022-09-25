set expandtab
set nowrap
set shiftwidth=4
set termguicolors
set undofile
set laststatus=0
set statusline=%F
set fillchars+=vert:\
set cmdheight=0
nnoremap <silent> <C-g> :echo expand("%") . " \| " . line(".") . "/" . line("$")<CR>
nnoremap <silent> <Esc> :noh<CR>
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'morhetz/gruvbox'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
call plug#end()
lua << EOF
local cmp = require("cmp")
cmp.setup {
    mapping = {
        ['<C-f>'] = cmp.mapping.scroll_docs(1), -- "forward"
        ['<C-b>'] = cmp.mapping.scroll_docs(-1), -- "back"
        ['<A-c>'] = cmp.mapping.complete(),
        ['<C-c>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback) cmp.select_next_item() end,
        ['<S-Tab>'] = function(fallback) cmp.select_prev_item() end,
    },
    sources = {{ name = "nvim_lsp" }},
}
for _, lsp in ipairs({"pylsp", "dartls", "rust_analyzer", "gopls", "clangd"}) do
    require("lspconfig")[lsp].setup{}
end
EOF
nnoremap <silent> <Leader>e :lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})<CR>
nnoremap <silent> <Leader>d :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>z :lua vim.lsp.buf.format { async = true }<CR>
nnoremap <silent> <Leader>x :lua vim.lsp.buf.code_action()<CR>
colorscheme gruvbox
highlight EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
