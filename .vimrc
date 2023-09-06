call plug#begin(stdpath('data') . '/plugged')

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vimicons
Plug 'ryanoasis/vim-devicons'

" vim-fugitive
Plug 'tpope/vim-fugitive'

Plug 'Olical/conjure'

Plug 'neovim/nvim-lspconfig'

call plug#end()

" General Config
filetype plugin indent on
let mapleader=";"
set clipboard+=unnamedplus
set splitbelow
set nu rnu
syntax on
set tabstop=8
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set nocompatible
set backspace=2
set backup
set backupdir=~/temp
set dir=~/temp
autocmd GUIEnter * simalt ~x
if has("gui_running")
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    let &guifont="FuraMono_Nerd_Font_Mono:h11:cANSI,EllographCF_NF_Regular:h11:cANSI"
    set encoding=utf8
    if has("win32") || has("win64") || has("win16")
        set renderoptions=type:directx
    endif
endif

set background=dark

" netrw Config
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 50
let g:netrw_altv = 1

" Buffer movement
nnoremap <leader>l :ls<cr>
nnoremap <leader>d :b#<bar>bd#<cr>
nnoremap <leader>f :bn<cr>
nnoremap <leader>g :e#<cr>

nnoremap <leader>b :25Lex<cr>

