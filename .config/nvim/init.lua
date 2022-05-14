require('plugins')
vim.cmd [[set clipboard=unnamedplus]]
vim.cmd [[colorscheme catppuccin]]
vim.cmd [[set relativenumber number]]
vim.cmd [[set expandtab smartindent]]
vim.cmd [[set tabstop=2]]
vim.cmd [[set shiftwidth=2]]
vim.api.nvim_set_keymap("n", "<space><tab>", ":bnext<cr>", {noremap = true})
