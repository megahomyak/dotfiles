set expandtab
set laststatus=0
nnoremap <c-g> 1<c-g>
noremap x "_x
noremap y "+y
noremap p "+p
autocmd BufNewFile,BufRead *.conf set noexpandtab
set shiftwidth=4
set mouse=a
au FileType dart setlocal shiftwidth=2
au FileType gitcommit setlocal wrapmargin=0
au FileType gitcommit setlocal textwidth=0
set termguicolors
set undofile
set scl=no
set shortmess=asIFTWc
let g:netrw_localrmdir='rm -r'
let g:netrw_banner = 0
set nofixeol
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
let g:gruvbox_contrast_dark = "hard"

Plug 'megahomyak/vim-nxml'

Plug 'machakann/vim-swap'

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <Space> <Plug>(easymotion-overwin-f)

Plug 'tpope/vim-fugitive'

Plug 'img-paste-devs/img-paste.vim'

Plug 'junegunn/limelight.vim'
nmap <silent> <Leader>l :Limelight!!<CR>
let g:limelight_default_coefficient = 1

if !do_not_lag_please
    Plug 'neovim/nvim-lspconfig'

    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/cmp-nvim-lsp'

    Plug 'hrsh7th/cmp-vsnip'

    Plug 'hrsh7th/vim-vsnip'
endif
call plug#end()

set langmap=йцукенгшщзхъ;qwfpgjluy\;[]
set langmap+=фывапролджэ;arstdhneio'
set langmap+=ячсмитьбю;zxcvbkm\\,.
set langmap+=ЙЦУКЕНГШЩЗХЪ;QWFPGJLUY:{}
set langmap+=ФЫВАПРОЛДЖЭ;ARSTDHNEIO\"
set langmap+=ЯЧСМИТЬБЮ;ZXCVBKM<>

if !do_not_lag_please
    silent! lua << EOF
    for _, lsp in ipairs({"dartls", "gopls", "clangd", "ts_ls"}) do
        require("lspconfig")[lsp].setup{}
    end
    require'lspconfig'.rust_analyzer.setup{
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true
          },
          diagnostics = {
            disabled = {"unlinked-file"}
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
nnoremap <silent> <Leader>z :lua vim.lsp.buf.format()<CR>
nnoremap <silent> <Leader>x :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <Leader>g <C-w>s:lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>t <C-w>s:lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <Leader>i :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>m :lua vim.lsp.buf.references()<CR>
colorscheme gruvbox

nnoremap k gk
nnoremap j gj
xnoremap <expr> j mode() ==# 'V' ? 'j' : 'gj'
xnoremap <expr> k mode() ==# 'V' ? 'k' : 'gk'

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'images'
let g:mdip_imgname = 'image'

command! -nargs=0 WriteAnyway :w !sudo mkdir -p "$(dirname %)" < /dev/null; sudo tee % > /dev/null

map <a-d> <Esc>
imap <a-d> <Esc>

command! UseMixtral execute "normal! iMODEL mixtral-8x7b-32768\<CR>USER "
