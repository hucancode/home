require('plugins')
vim.cmd("colorscheme catppuccin")
vim.cmd("set mouse+=a")
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.g.netrw_banner = 0
vim.api.nvim_set_keymap("n", "<space><tab>", ":bnext<cr>", {noremap = true})
vim.api.nvim_set_keymap("", "d", "\"_d", {noremap = true})
vim.api.nvim_set_keymap("", "D", "\"_D", {noremap = true})
vim.api.nvim_set_keymap("", "c", "\"_c", {noremap = true})
vim.api.nvim_set_keymap("", "C", "\"_C", {noremap = true})
vim.api.nvim_set_keymap("v", "p", "\"_p", {noremap = true})
vim.api.nvim_set_keymap("v", "P", "\"_P", {noremap = true})
