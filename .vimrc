set clipboard+=unnamedplus

set number
set mouse=a
set guitablabel=%t
set hidden 
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_chgwin=1
noremap <F2> :bprevious<CR>
noremap <F3> :bnext<CR>
nnoremap <Leader>q :bd<CR>

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Import plugins
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'bfrg/vim-cpp-modern'
Plug 'evanleck/vim-svelte'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'codechips/coc-svelte', {'do': 'npm install'}
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-vinegar'
call plug#end()

colorscheme nord

let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_c_only_filename = 1
let g:airline_section_z = ''

let b:coc_diagnostic_disable = 1

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :Rg<CR>
