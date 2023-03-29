local manager = require('packer')

function theme()
    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    require("catppuccin").setup()
    vim.cmd("colorscheme catppuccin")
end

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

function status()
    require('lualine').setup({
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
        lualine_x = {},
        lualine_y = {{
            "macro-recording",
            fmt = show_macro_recording,
        }},
        lualine_z = {'searchcount'},
      },
    })
    require("which-key").setup {
      key_labels = {
        ["<space>"] = "␣",
        ["<CR>"] = " ",
        ["<esc>"] = " ",
        ["<bs>"] = " ",
        ["<Tab>"] = " ",
      },
      layout = {
        height = { min = 1, max = 4 }, 
        width = { min = 20, max = 50 },
      }
    }
end

function explorer()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
      },
      pickers = {
        find_files = {
          results_title=" JUMP TO FILE",
          prompt_title=false,
          preview_title=false,
        },
        buffers = {
          results_title=" OPENNED FILES",
          prompt_title=false,
          preview_title=false,
        },
        live_grep = {
          results_title=" FUZZY FINDER",
          prompt_title=false,
          preview_title=false,
        }
      },
    })
    local wk = require("which-key")
    wk.register({
      ["<space>"] = {
        name = "File",
        f = { 
          function() require("telescope.builtin").find_files() end, 
          "Jump to File"
        }, 
        ["<space>"] = { 
          function() require('telescope.builtin').live_grep() end, 
          "Fuzzy Finder" 
        }, 
        ["<tab>"] = { 
          function() require('telescope.builtin').buffers() end, 
          "Buffers" 
        },
      },
      ["<tab>"] = { "<cmd>b#<cr>", "Last Buffer" },
    })
end

function lsp()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "lua",
        "bash", 
        "fish",
        "typescript",
        "javascript",
        "css",
        "html",
        "json",
        "svelte",
        "dart",
        "kotlin",
        "swift",
        "c", 
        "cpp", 
        "rust",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
    require('nvim_comment').setup()
    vim.api.nvim_set_keymap("", "<C-c>", ":CommentToggle<cr>", {
        noremap = true
    })
    local lsp = require('lsp-zero').preset({
      name = 'minimal',
      set_lsp_keymaps = false,
      manage_nvim_cmp = true,
      suggest_lsp_servers = false,
    })
    lsp.ensure_installed({
      'clangd',
      'html',
      'cssls',
      'tsserver',
      'svelte',
      'tailwindcss',
      'rust_analyzer',
    })
    lsp.setup()
    -- hide all errors and warning
    vim.diagnostic.config({
      virtual_text = false,
      signs = false,
      underline = false,
      update_in_insert = false,
      severity_sort = false,
    })
    local wk = require("which-key")
    wk.register({
        g = {
          D = { function() vim.lsp.buf.declaration() end, "Go to declaration", noremap=true },
          d = { function() vim.lsp.buf.definition() end, "Go to defination", noremap=true },
          i = { function() vim.lsp.buf.implementation() end, "Go to implementation", noremap=true },
        }
    })
end

function setup(use)
    use 'wbthomason/packer.nvim'
    use {
        "catppuccin/nvim",
        as = "catppuccin"
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
      "folke/which-key.nvim",
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use 'terrortylor/nvim-comment'
    use 'nvim-treesitter/nvim-treesitter'
    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},         -- Required
        {'hrsh7th/cmp-nvim-lsp'},     -- Required

        -- Snippets
        {'L3MON4D3/LuaSnip'},             -- Required
      }
    }
    theme()
    status()
    explorer()
    lsp()
end

return manager.startup(setup)
