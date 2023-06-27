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

ll.setup({
  options = {
    theme = 'catppuccin',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  tabline = {
    lualine_a = {{
      'buffers', 
      hide_filename_extension = true,
      max_length = vim.o.columns,
      symbols = {
        modified = ' ',      -- Text to show when the buffer is modified
        alternate_file = '  ', -- Text to show to indify the alternate file
        directory =  '',     -- Text to show when the buffer is a directory
      },
      filetype_names = {
        TelescopePrompt = '',
        dashboard = '',
        packer = '',
        fzf = '',
        alpha = ''
      }
    }},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  sections = {
    lualine_a = {{
      'mode',
      icon = '',
    }},
    lualine_b = {
      {
        'encoding',
        icon = '',
      }, 
      'diagnostics'
    },
    lualine_c = {
      {
        'filetype',
        icon_only = true,
        separator = '',
      },
      {
        'filename',
        path = 1,
        symbols = {
          modified = ' ',
          readonly = ' ',
          unnamed =  ' 󰡯',
        },
      }
    },
    lualine_x = {{
      'location',
      icon = '',
    },{
      'progress',
    }},
    lualine_y = {},
    lualine_z = {},
  },
})

wk.setup {
  key_labels = {
    ['<space>'] = 'SPACE',
    ['<CR>'] = 'ENTER',
    ['<esc>'] = 'ESC',
    ['<bs>'] = 'BACKSPACE',
    ['<Tab>'] = 'TAB',
  },
  layout = {
    height = { min = 1, max = 4 }, 
    width = { min = 20, max = 50 },
  },
  show_help = false,
  show_keys = false,
}

telescope.setup({
  defaults = {
    borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
  },
  pickers = {
    find_files = {
      results_title='󱙷 JUMP TO FILE',
      prompt_title=false,
      preview_title=false,
    },
    buffers = {
      results_title='󰏒 OPENNED FILES',
      prompt_title=false,
      preview_title=false,
    },
    live_grep = {
      results_title='󱇪 FUZZY FINDER',
      prompt_title=false,
      preview_title=false,
    }
  },
})

wk.register({
  ['<space>'] = {
    f = { 
      tdialog.find_files, 
      'Jump to File'
    }, 
    ['<space>'] = { 
      tdialog.live_grep, 
      'Fuzzy Finder' 
    }, 
    b = { 
      tdialog.buffers, 
      'Buffers' 
    },
    ['<tab>'] = {
      tdialog.resume,
      'Open last picker'
    }
  },
  ['<tab>'] = { '<cmd>b#<cr>', 'Last Buffer' },
})
