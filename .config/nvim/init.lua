if not vim.g.vscode then
  require('plugins')
  vim.cmd("set mouse+=a")
  vim.opt.relativenumber = true
  vim.opt.number = true
  vim.opt.cursorline = true
  vim.g.netrw_banner = 0
  vim.opt.timeoutlen = 200
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
end

if vim.fn.executable('win32yank') == 1 then 
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank -i --crlf",
      ["*"] = "win32yank -i --crlf"
    },
    paste = {
      ["+"] = "win32yank -o --lf",
      ["*"] = "win32yank -o --lf"
    },
    cache_enable = 0,
  }
end

vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_keymap("", "d", "\"_d", {noremap = true})
vim.api.nvim_set_keymap("", "D", "\"_D", {noremap = true})
vim.api.nvim_set_keymap("", "c", "\"_c", {noremap = true})
vim.api.nvim_set_keymap("", "C", "\"_C", {noremap = true})
vim.api.nvim_set_keymap("v", "p", "\"_p", {noremap = true})
vim.api.nvim_set_keymap("v", "P", "\"_P", {noremap = true})
