set colorcolumn=100  " 100th column is filled
set number  " Line numbers on the left
set nowrap  " No word wrap
set tabstop=4  " Tabs will look like 4 spaces
set shiftwidth=4  " 4 spaces for non-TAB indent
set softtabstop=4  " <Tab> will place spaces to this value
set expandtab  " 4 spaces instead of <Tab>
set previewheight=5  " Make preview window small
set scrolloff=5  " Don't let the cursor to go too close to the first or last line
set cursorline  " Underline the current line
set encoding=utf-8
set termguicolors  " Correct colors in Windows terminal (and probably some other terminals)
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set nocompatible  " No compatibility with Vi
let mapleader="\\"
language en_US.UTF-8
set undofile  " Save undo stack between sessions
set fileformat=unix  " LF > CRLF


" Quick replacement command
nnoremap <Leader>1 :%s/\v//g<left><left><left>
" Register that consumes everything
nnoremap <Leader>2 "_
" Quick replacement command, but regex is disabled
nnoremap <Leader>3 :%s///g<left><left><left>
" Delete the symbol after the current word and go to the insert mode
nnoremap <Leader>4 hels
" Quick replacement command, but only for the current line
nnoremap <Leader>5 :s/\v//g<left><left><left>

nnoremap / /\v
nnoremap ? ?\v

if has('win32')
    set shell=powershell
    set shellcmdflag=-command
endif

command EnableHTMLTagMatching inoremap <buffer> / /<C-x><C-o>| set omnifunc=htmlcomplete#CompleteTags
command DisableHTMLTagMatching inoremap <buffer> / /
autocmd FileType html EnableHTMLTagMatching
autocmd FileType template EnableHTMLTagMatching
autocmd FileType json setlocal conceallevel=0
autocmd FileType markdown setlocal conceallevel=0
autocmd FileType markdown setlocal textwidth=79


autocmd FileType go setlocal noexpandtab

command Dump tabnew ~/vim_dump.txt
command SecDump tabnew ~/secure_vim_dump.txt
command Notes tabnew notes.txt | ToggleWrap

function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        silent! nunmap <buffer> k
        silent! nunmap <buffer> j
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        noremap  <buffer> <silent> k      gk
        noremap  <buffer> <silent> j      gj
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
    endif
endfunction

command ToggleWrap call ToggleWrap()
command -nargs=1 Wraptab tabnew <f-args> | call ToggleWrap()

command Config tabnew ~/.config/nvim/init.vim

command CloseAllTabsToTheRight .+1,$ tabdo :tabc
command CloseAllTabsToTheLeft 1,-. tabdo :tabc

" Preserving the selection when doing < or > in visual mode
vnoremap < <gv
vnoremap > >gv

" Just a little bit faster
nnoremap <Leader>q <C-w>w

" Terminal thingys
command TSplit new | terminal
command TTab tabnew | terminal
tnoremap <Esc> <C-\><C-n>

" Quickly move to the left and right tabs
nnoremap <C-Left> gT
nnoremap <C-Right> gt

" Quickly move the current tab to the left or to the right
nnoremap <silent> <A-Left> :-tabmove<CR>
nnoremap <silent> <A-Right> :+tabmove<CR>

" Move only the screen
nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>

" To copy/paste from VIM to the clipboard
vnoremap <silent> <C-c> "+y
vnoremap <silent> <C-x> "+d
inoremap <silent> <C-v> <Cmd>set paste<CR><C-R>+<Cmd>set nopaste<CR>

" For compact keyboards (and actually kinda useful)
noremap <A-d> <Esc>
lnoremap <A-d> <Esc>
inoremap <A-d> <Esc>
cnoremap <A-d> <Esc>

" Turn off the highlighting by pressing Esc
nnoremap <silent> <Esc> :noh<CR>:CloseAllFloatingWindows<CR>

filetype on  " File type recognition

let $BASH_ENV="~/.bashrc"  " Don't forget to add `shopt -s expand_aliases` to your .bashrc

" Select all using Ctrl + A
noremap <silent> <C-a> <esc>ggVG
" Move to the right by half of screen
nnoremap <silent> <Right> zL
" Move to the left by half of screen
nnoremap <silent> <Left> zH
" Move downwards by half of screen
nnoremap <silent> <Down> <C-d>
" Move upwards by half of screen
nnoremap <silent> <Up> <C-u>

" Change current word
nnoremap , "_ciw

" Select to the last non-whitespace character, instead of selecting the
" trailing newline character
vnoremap $ g_


let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'

Plug 'L3MON4D3/LuaSnip'

Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'saadparwaiz1/cmp_luasnip'

Plug 'ray-x/lsp_signature.nvim'

Plug 'nicwest/vim-camelsnek'

Plug 'preservim/nerdcommenter'

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'Yggdroot/indentLine'
let g:indentLine_char = '▏'

Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_guicolor='darkred'

Plug 'easymotion/vim-easymotion'
" Go to any symbol on the screen by pressing .
nmap <silent> <Space> <Plug>(easymotion-bd-f)

Plug 'jiangmiao/auto-pairs'
autocmd FileType rust let b:AutoPairs = AutoPairsDefine({'<': '>//n'}, ["'"])  " Adding < > pairs, removing ' ' pairs
let g:AutoPairsMultilineClose = 0  " Do not remove whitespaces between quotes if they are on the different lines and the first one is closed

Plug 'simrat39/rust-tools.nvim'

Plug 'arithran/vim-delete-hidden-buffers'

Plug 'wesQ3/vim-windowswap'

"Plug 'romgrk/barbar.nvim'
"function ChangeTabColors()
"    echo 1
"    hi BufferInactive guibg=#000000 guifg=#000000
"endfunction
"autocmd ColorScheme call ChangeTabColors()
"let bufferline = get(g:, 'bufferline', {})
"let bufferline.icons = v:false
"let bufferline.icon_pinned = "T"
"let bufferline.auto_hide = v:true
"let bufferline.closable = v:false
"let bufferline.maximum_padding = 1

Plug 'preservim/nerdtree'
let g:NERDTreeIgnore = []  " Because by default it ignores .db
let g:NERDTreeWinSizeMax = 30
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrows = 0

Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'M',
    \ 'Staged'    :'*',
    \ 'Untracked' :'!',
    \ 'Renamed'   :'R',
    \ 'Unmerged'  :'<>',
    \ 'Deleted'   :'D',
    \ 'Dirty'     :'!',
    \ 'Clean'     :'',
    \ 'Ignored'   :'X',
    \ 'Unknown'   :'?',
    \ }
let g:NERDTreeGitStatusShowIgnored = 1

Plug 'jistr/vim-nerdtree-tabs'
nnoremap <silent> <Leader>0 :NERDTreeTabsToggle<CR>
" Resizes this goddamn window to acceptable 30 columns (because if that thing
" stretches in one tab, it also stretches in the others)
command Back vert res 30

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
nnoremap <Leader>f :FZF<CR>
let g:fzf_action = {"enter": "tab split"}

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-obsession'

Plug 'bkad/CamelCaseMotion'
nmap <silent> w <Plug>CamelCaseMotion_w
nmap <silent> e <Plug>CamelCaseMotion_e
nmap <silent> e <Plug>CamelCaseMotion_e
nmap <silent> b <Plug>CamelCaseMotion_b

Plug 'brooth/far.vim'

Plug 'vim-scripts/Tabmerge'

Plug 'DataWraith/auto_mkdir'

Plug 'lambdalisue/suda.vim'

Plug 'tpope/vim-surround'

" Plug 'HallerPatrick/py_lsp.nvim'

Plug 'junegunn/limelight.vim'

Plug 'junegunn/goyo.vim'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

Plug 'kien/rainbow_parentheses.vim'
au VimEnter * RainbowParenthesesToggleAll
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_contrast_light = "medium"
command Dark set bg=dark
command Light set bg=light
Dark

call plug#end()
colorscheme gruvbox


lua << EOF
-- A nasty workaround to add the still-not-released logger functionality
require('vim.lsp.log').levels["OFF"] = #require('vim.lsp.log').levels + 1
vim.lsp.set_log_level("OFF")

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = false

local lspconfig = require('lspconfig')

require "lsp_signature".setup({
    floating_window = false,
    hint_enable = false,
    always_trigger = true
})

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'gopls' }  -- pylsp is turned off because it is very slow and buggy
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

require('rust-tools').setup {
  tools = {
    autoSetHints = true,
    hover_with_actions = false,
  },
  server = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          autoreload = true,
          runBuildScripts = true,
        },
        checkOnSave = {
          overrideCommand = {
              "cargo",
              "clippy",
              "--message-format=json",
              "--",
              "-W",
              "clippy::all",
              "-W",
              "clippy::pedantic",
              "-W",
              "clippy::nursery",
              "-W",
              "clippy::cargo"
          },
          -- command = "clippy",
          enable = true,
        },
        completion = {
          autoimport = {
            enable = true,
          },
        },
        diagnostics = {
          disabled = {"macro-error"},
        },
        inlayHints = {
          chainingHints = false,
          chainingHintsSeparator = "> ",
          enable = true,
          typeHints = true,
          typeHintsSeparator = "> ",
        },
        procMacro = {
          enable = true,
        },
      },
    },
  }
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<A-c>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            -- elseif luasnip.expand_or_jumpable() then
                -- luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            -- elseif luasnip.jumpable(-1) then
                -- luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    preselect = cmp.PreselectMode.None,
}

local lsp_signature = require("lsp_signature")

function current_signature()
    local sig = lsp_signature.status_line()
    if sig.hint == "" then
        return ""
    end
    return "| " .. sig.hint
end

function diagnostics()
    local warnings_amount = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local errors_amount = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    if warnings_amount == 0 and errors_amount == 0 then
        return ""
    end
    local string = "|"
    if warnings_amount ~= 0 then
        string = string .. " !" .. warnings_amount
    end
    if errors_amount ~= 0 then
        string = string .. " X" .. errors_amount
    end
    return string
end
EOF

set statusline=[%n]\ %F%(\ %m%)\ %l/%L\ (%p%%)%(\ %{v:lua.diagnostics()}%)%(\ \|\ git:%{FugitiveStatusline()[5:-3]}%)%(\ %{v:lua.current_signature()}%)\ \|\ ff:%{&fileformat}%<

nnoremap <silent> <Leader>e :lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})<CR>
nnoremap <silent> <Leader>d :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>z :lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <Leader>x :lua vim.lsp.buf.code_action()<CR>
command Hdef lua vim.lsp.buf.definition()
command Def silent normal <C-w>s:lua vim.lsp.buf.definition()<CR>
command Tdef silent normal <C-w>s<C-w>T:lua vim.lsp.buf.definition()<CR>
command Htype lua vim.lsp.buf.type_definition()
command Ttype silent normal <C-w>s<C-w>T:lua vim.lsp.buf.type_definition()<CR>
command Type silent normal <C-w>s:lua vim.lsp.buf.type_definition()<CR>
command Impl lua vim.lsp.buf.implementation()
command Ref lua vim.lsp.buf.references()

command CloseAllFloatingWindows lua _G.CloseAllFloatingWindows()
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

" Path completion
inoremap <C-b> <C-x><C-f>

command BufPath normal 1<C-g>

" Disable quote concealing in json
let g:vim_json_conceal=0

" Executes the command under the cursor
command Execute execute getline(".")

" A shortcut to invoke Omnifunc
imap <A-x> <C-x><C-o>
imap <A-i> <C-x><C-i>

" Don't want to mess with my registers
nnoremap x "_x
vnoremap x "_x
vnoremap s "_s
xnoremap p pgvy

command CargoPlay !cargo play %
