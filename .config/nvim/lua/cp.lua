vim.cmd 'let g:CPTimeLimit=2'
vim.cmd 'command NewCP :read ~/.config/cp/template.%:e <bar> :e %:r.in <bar> :b#'
vim.cmd "command BuildCP :execute '!g++ -std=c++17 % -o %:r && timeout' CPTimeLimit './%:r <%:r.in >%:r.out'"
vim.cmd 'autocmd filetype cpp nnoremap <F5> :silent w <bar> :BuildCP <CR>'
