call plug#begin(stdpath('data') . '/plugged')

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vimicons
Plug 'ryanoasis/vim-devicons'

" CSV.vim
Plug 'chrisbra/csv.vim'

" OmniSharp
Plug 'OmniSharp/omnisharp-vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'dense-analysis/ale'
Plug 'andreypopp/asyncomplete-ale.vim'

if has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
endif

" vim-clap
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }

" vim-fugitive
Plug 'tpope/vim-fugitive'

" csv.vim
Plug 'chrisbra/csv.vim'

" vim-signify
Plug 'mhinz/vim-signify'

" vim-typescript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-projectionist'

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

" Clap config
nnoremap <c-t> :Clap files<cr>
nnoremap <c-b> :Clap filer<cr>

" Airline Config
let g:airline_theme='dark'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 30
let g:airline#extensions#branch#sha1_len = 10
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'short_path'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['netrw']
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" vim-signify
set updatetime=100

" C# configs w/ OmniSharp and Asyncomplete
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'clap'
let g:OmniSharp_selector_findusages = 'clap'
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  set previewheight=5
endif
autocmd FileType cs nmap <silent> <buffer> <F12> :OmniSharpGotoDefinition<cr>
autocmd FileType cs nmap <silent> <buffer> <A-F> :OmniSharpCodeFormat<cr>
autocmd FileType cs nmap <silent> <buffer> <A-t> :OmniSharpRunTest<cr>
autocmd FileType cs nmap <silent> <buffer> <A-T> :OmniSharpRunTestsInFile<cr>
autocmd FileType cs nmap <silent> <buffer> <C-S-b> <Plug>(omnisharp_global_code_check)
" Asyncomplete tab completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <cr>  pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" Typescript configs
let g:projectionist_heuristics = {
            \  "src/app|angular.json": {
            \    "src/*.component.ts": {
            \      "alternate": "src/{}.component.html",
            \      "type": "source"
            \    },
            \    "src/*.component.spec.ts": {
            \      "alternate": "src/{}.component.ts",
            \      "type": "spec"
            \    },
            \    "src/*.component.scss": {
            \      "alternate": "src/{}.component.ts",
            \      "type": "style"
            \    },
            \    "src/*.component.html": {
            \      "alternate": "src/{}.component.ts",
            \      "type": "html"
            \    }
            \  }
            \}

nmap <A-u> :Esource<cr>
nmap <A-i> :Estyle<cr>
nmap <A-o> :Ehtml<cr>
nmap <A-p> :Espec<cr>

" ALE Config
let g:ale_linters = {
\    'cs': [ 'OmniSharp' ],
\    'javascript': [ 'eslint' ],
\    'typescript': [ 'tslint' ]
\ }
let g:ale_fixers = {
\   '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
\   'javascript': [ 'eslint', 'prettier' ],
\   'typescript': [ 'tslint', 'prettier' ]
\ }
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_completion_autoimport = 1
set omnifunc=ale#completion#OmniFunc
let g:airline#extensions#ale#enabled = 1

" Google Search
function! GoogleText(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]y"
  else
    silent exe "normal! `[v`]y"
  endif

  let search = substitute(trim(@@), ' \+', '+', 'g')
  silent exe "!start https://google.com/search?q=" . search

  let &selection = sel_save
  let @@ = reg_save
endfunction

" CSV.vim config
nmap <silent> gs :set opfunc=GoogleText<CR>g@
vmap <silent> gs :<C-u>call GoogleText(visualmode(), 1)<Cr>
