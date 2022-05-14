require('plugins')
vim.cmd [[set mouse+=a]]
vim.cmd [[set clipboard=unnamedplus]]
vim.cmd [[colorscheme catppuccin]]
vim.cmd [[set relativenumber number]]
vim.cmd [[set expandtab smartindent]]
vim.cmd [[set tabstop=2]]
vim.cmd [[set shiftwidth=2]]
vim.cmd [[let g:netrw_banner=0]]
vim.api.nvim_set_keymap("n", "<space><tab>", ":bnext<cr>", {noremap = true})
vim.api.nvim_set_keymap("", "d", "\"_d", {noremap = true})
vim.api.nvim_set_keymap("", "D", "\"_D", {noremap = true})
vim.api.nvim_set_keymap("", "c", "\"_c", {noremap = true})
vim.api.nvim_set_keymap("", "C", "\"_C", {noremap = true})
vim.api.nvim_set_keymap("v", "p", "\"_p", {noremap = true})
vim.api.nvim_set_keymap("v", "P", "\"_P", {noremap = true})
