local manager = require('packer')

function theme()
    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    require("catppuccin").setup()
    vim.cmd("colorscheme catppuccin")
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
        lualine_z = {}
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'diagnostics'},
        lualine_c = {{
          'filename',
          symbols = {
            modified = '  ',
            readonly = ' ',
            unnamed =  '[No Name]',
          },
        }},
        lualine_x = {{
          'filetype', 
          icon_only = true
        }},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
    })
    require("which-key").setup {
      key_labels = {
        ["<space>"] = "SPACE",
        ["<cr>"] = "ENTER",
        ["<tab>"] = "TAB",
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
        live_grep = {
          results_title=" FUZZY FINDER",
          prompt_title=false,
          preview_title=false,
        }
      },
      extensions = {
        file_browser = {
          results_title=" FILE BROWSER",
          prompt_title=false,
          preview_title=false,
        }
      }
    })
    telescope.load_extension("file_browser")
    local wk = require("which-key")
    wk.register({
      ["<F9>"] = {
        name = "File",
        f = { 
          function() require("telescope.builtin").find_files() end, 
          "Jump to File"
        }, 
        b = { 
          function() telescope.extensions.file_browser.file_browser() end,
          "File Browser"
        }, 
        g = { 
          function() require('telescope.builtin').live_grep() end, 
          "Fuzzy Finder" 
        }, 
      },
      ["<tab>"] = { "<cmd>b#<cr>", "Last Buffer" },
      g = {
        name = "Go to",
        ["<tab>"] = { "<cmd>b#<cr>", "Last Buffer" },
        t = { "<cmd>bnext<cr>", "Next Buffer" },
        T = { "<cmd>bprevious<cr>", "Previous Buffer" }
      },
    })
    
    vim.g.loaded_netrwPlugin = true
    vim.api.nvim_create_autocmd(
      {
        "VimEnter"
      },
      { 
        pattern = "*", 
        callback = function()
          local no_argv = #vim.v.argv <= 1
          local directory = #vim.v.argv <= 2 and vim.fn.isdirectory(vim.v.argv[2]) ~= 0
          if directory then
            vim.api.nvim_command("cd " .. vim.v.argv[2])
          end
          if no_argv or directory then
            telescope.extensions.file_browser.file_browser()
          end
        end,
      }
    )
end

function lsp()
    require('nvim-treesitter.configs').setup({
      highlight = { enable = true },
      indent = { enable = true },
    })
    require('nvim_comment').setup()
    vim.api.nvim_set_keymap("", "<C-_>", ":CommentToggle<cr>", {
        noremap = true
    })
    vim.opt.completeopt = {"menu", "menuone", "noselect"}
    local cmp = require('cmp')
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end
        },
        view = {
            entries = "native"
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({
                select = true
            }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({{
            name = 'nvim_lsp'
        }}, {{
            name = 'buffer'
        }}),
        window = {
            documentation = {
                max_width = 70
            }
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 70)
            return vim_item
          end
        }
    })
    local lsp = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = {'clangd', 'jdtls'}
    for _, server in pairs(servers) do
        lsp[server].setup { capabilities = capabilities }
    end
    -- lsp.clangd.setup {
    --   capabilities = capabilities,
    --   cmd = { "clangd", "--completion-style=detailed" }
    -- }
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

function cp()
    vim.cmd 'autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -std=c++17 % -o %:r && ./%:r <%:r.in >%:r.out <CR>'
end
function setup(use)
    use 'wbthomason/packer.nvim'
    use {
        "catppuccin/nvim",
        as = "catppuccin"
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
      "folke/which-key.nvim",
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'terrortylor/nvim-comment'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    theme()
    status()
    explorer()
    lsp()
    cp()
end

return manager.startup(setup)
