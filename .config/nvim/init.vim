set expandtab
set mouse=
set nowrap
set shiftwidth=4
au FileType dart set shiftwidth=2
set termguicolors
set undofile
set laststatus=0
set statusline=%F
set cmdheight=0
set shortmess=asIF
nnoremap <silent> <C-g> :echo expand("%") . (&mod ? " [+]" : "") . " \| " . line(".") . "/" . line("$")<CR>
nnoremap <silent> <Esc> :noh<CR>
nnoremap <silent> <Leader>n :Lexplore<CR><CR>
au ColorScheme * highlight EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_guicolor='darkred'
Plug 'morhetz/gruvbox'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'cohama/lexima.vim'
call plug#end()
call lexima#add_rule({'char': '<', 'input_after': '>', 'filetype': 'rust'})
call lexima#add_rule({'char': '>', 'at': '\%#>', 'leave': 1, 'filetype': 'rust'})
call lexima#add_rule({'char': '<BS>', 'at': '<\%#>', 'delete': 1, 'filetype': 'rust'})
call lexima#add_rule({'char': "'", 'input_after': '', 'filetype': 'rust'})
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
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    sources = {{ name = "nvim_lsp" }},
}
for _, lsp in ipairs({"dartls", "rust_analyzer", "gopls", "clangd"}) do
    require("lspconfig")[lsp].setup{}
end
EOF
nnoremap <silent> <Leader>e :lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})<CR>
nnoremap <silent> <Leader>d :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>z :lua vim.lsp.buf.format { async = true }<CR>
nnoremap <silent> <Leader>x :lua vim.lsp.buf.code_action()<CR>
colorscheme gruvbox
