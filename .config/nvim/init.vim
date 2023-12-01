set expandtab
set shiftwidth=4
au FileType dart setlocal shiftwidth=2
set termguicolors
set undofile
set scl=no
set shortmess=asIFTWc
let g:netrw_localrmdir='rm -r'
au BufReadPost * set bufhidden=wipe
lua<<EOF
_G.CloseAllFloatingWindows = function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then  -- is_floating_window?
      vim.api.nvim_win_close(win, false)  -- do not force
    end
  end
end
EOF
nnoremap <silent> <Esc> :lua _G.CloseAllFloatingWindows()<CR>
let do_not_lag_please = 0
call plug#begin()
Plug 'morhetz/gruvbox'

Plug 'megahomyak/vim-nxml'

Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-fugitive'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <Space> <Plug>(easymotion-overwin-f)

set langmap=йцукенгшщзхъ;qwfpgjluy\;[]
set langmap+=фывапролджэ;arstdhneio'
set langmap+=ячсмитьбю;zxcvbkm\\,.
set langmap+=ЙЦУКЕНГШЩЗХЪ;QWFPGJLUY:{}
set langmap+=ФЫВАПРОЛДЖЭ;ARSTDHNEIO\"
set langmap+=ЯЧСМИТЬБЮ;ZXCVBKM<>

if !do_not_lag_please
    Plug 'neovim/nvim-lspconfig'

    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/cmp-nvim-lsp'

    Plug 'hrsh7th/cmp-vsnip'

    Plug 'hrsh7th/vim-vsnip'
endif
call plug#end()
if !do_not_lag_please
    lua << EOF
    for _, lsp in ipairs({"dartls", "gopls", "clangd", "tsserver", "pyright"}) do
        require("lspconfig")[lsp].setup{}
    end
    require'lspconfig'.rust_analyzer.setup{
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true
        }
      }
    }
  }

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
        snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
        sources = {{ name = "nvim_lsp" }, { name = "vsnip" }},
        preselect = cmp.PreselectMode.None,
    }
EOF
endif
if !do_not_lag_please
    imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
    imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
end
nnoremap <silent> <Leader>e :lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})<CR>
nnoremap <silent> <Leader>d :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>z :lua vim.lsp.buf.formatting { async = true }<CR>
nnoremap <silent> <Leader>x :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <Leader>g <C-w>s:lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>t <C-w>s:lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <Leader>i :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>m :lua vim.lsp.buf.references()<CR>
colorscheme gruvbox

nnoremap k gk
nnoremap j gj
