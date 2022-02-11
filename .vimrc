set clipboard=unnamedplus
set number
set mouse=a
set guitablabel=%t
set hidden 
noremap <F2> :bprevious<CR>
noremap <F3> :bnext<CR>
noremap <F4> :bdelete<CR>
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=750
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
filetype plugin on
syntax on

" Import plugins
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdcommenter'
Plug 'evanleck/vim-svelte'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'codechips/coc-svelte', {'do': 'npm install'}
Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme nord

let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_c ='%#String#F2 %#Normal#Previous %#Comment#| %#String#F3 %#Normal#Next %#Comment#| %#String#F4 %#Normal#Close %#Comment#| %#String#\o %#Normal#Open %#Comment#| %#String#\f %#Normal#Find Files %#Comment#| %#String#\F %#Normal#Find in Files'
let g:airline_section_x =''
let g:airline_section_z =''
" let g:airline_section_warning = ''
let g:airline_section_error = ''

let b:coc_diagnostic_disable = 1
let g:ranger_replace_netrw = 1
let g:ranger_map_keys = 0
nnoremap <Leader>o :Ranger<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :Rg<CR>
