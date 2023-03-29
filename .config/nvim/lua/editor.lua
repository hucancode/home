vim.cmd("set mouse+=a")
vim.cmd("set ai")
vim.opt.number = true
vim.opt.statusline = " %f %h%m%r %=%{strlen(&fenc)?&enc:&fenc} "
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.cursorline = true
vim.g.netrw_banner = 0
vim.opt.timeoutlen = 200
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.api.nvim_set_hl(0, "Normal", { guibg = none })
vim.api.nvim_set_hl(0, "NormalNC", { guibg = none })
vim.api.nvim_set_hl(0, "NormalFloat", { guibg = none })
