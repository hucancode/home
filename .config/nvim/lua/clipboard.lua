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
