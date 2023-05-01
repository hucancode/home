local telescope = require('telescope')
local tdialog = require('telescope.builtin')
local wk = require('which-key')
local ll = require('lualine')
local cat = require('catppuccin')

vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha
cat.setup()
vim.cmd('colorscheme catppuccin')
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

local function show_macro_recording()
    local slot = vim.fn.reg_recording()
    if slot == '' then
        return ''
    else
        return 'Recording @' .. slot
    end
end
ll.setup({
  options = {
    theme = 'catppuccin',
  },
  tabline = {
    lualine_a = {{
      'buffers', 
      hide_filename_extension = true,
      max_length = vim.o.columns,
      symbols = {
        modified = '  ',      -- Text to show when the buffer is modified
        alternate_file = '  ', -- Text to show to indify the alternate file
        directory =  '',     -- Text to show when the buffer is a directory
      },
    }},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_c = {{
      'filename',
      path = 1,
      symbols = {
        modified = '  ',
        readonly = ' ',
        unnamed =  '[No Name]',
      },
    }},
    lualine_b = {'encoding'},
    lualine_x = {'location'},
    lualine_y = {{
        'macro-recording',
        fmt = show_macro_recording,
    }},
    lualine_z = {'searchcount'},
  },
})

wk.setup {
  key_labels = {
    ['<space>'] = '␣',
    ['<CR>'] = ' ',
    ['<esc>'] = ' ',
    ['<bs>'] = ' ',
    ['<Tab>'] = ' ',
  },
  layout = {
    height = { min = 1, max = 4 }, 
    width = { min = 20, max = 50 },
  }
}

telescope.setup({
  defaults = {
    borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
  },
  pickers = {
    find_files = {
      results_title=' JUMP TO FILE',
      prompt_title=false,
      preview_title=false,
    },
    buffers = {
      results_title=' OPENNED FILES',
      prompt_title=false,
      preview_title=false,
    },
    live_grep = {
      results_title=' FUZZY FINDER',
      prompt_title=false,
      preview_title=false,
    }
  },
})

wk.register({
  ['<space>'] = {
    name = 'File',
    f = { 
      tdialog.find_files, 
      'Jump to File'
    }, 
    ['<space>'] = { 
      tdialog.live_grep, 
      'Fuzzy Finder' 
    }, 
    ['<tab>'] = { 
      tdialog.buffers, 
      'Buffers' 
    },
  },
  ['<tab>'] = { '<cmd>b#<cr>', 'Last Buffer' },
})
