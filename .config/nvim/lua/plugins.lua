local manager = require('packer')

function packer(use)
    use 'wbthomason/packer.nvim'
end

function theme(use)
    use {
        "catppuccin/nvim",
        as = "catppuccin"
    }
end

function buffer(use)
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons'
    }
    require("bufferline").setup({
        options = {
            show_close_icon = false
        }
    })
end

function status(use)
    use 'feline-nvim/feline.nvim'
    vim.opt.termguicolors = true
    require('feline').setup({
        components = require('catppuccin.core.integrations.feline')
    })
    use {
      "folke/which-key.nvim",
    }
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

function explorer(use)
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    require('telescope').setup()
    require("telescope").load_extension "file_browser"
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        f = {
          name = "File", -- optional group name
          f = { "<cmd>Telescope find_files<cr>", "Find File", noremap=true }, -- create a binding with label
          b = { "<cmd>Telescope file_browser<cr>", "File Browser", noremap=true }, -- additional options for creating the keymap
        },
        w = { "<cmd>bdelete<cr>", "Close Buffer", noremap=true },
        W = { "<cmd>enew<cr>", "New Buffer", noremap=true },
        n = { "<cmd>bnext<cr>", "Next Buffer", noremap=true }, 
        N = { "<cmd>bprevious<cr>", "Previous Buffer", noremap=true }, 
      }
    })
end

function lsp(use)
    use 'nvim-treesitter/nvim-treesitter'
    require('nvim-treesitter.configs').setup({})
    use 'terrortylor/nvim-comment'
    require('nvim_comment').setup()
    vim.api.nvim_set_keymap("", "<C-_>", ":CommentToggle<cr>", {
        noremap = true
    })
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    vim.opt.completeopt = {"menu", "menuone", "noselect"}
    local cmp = require('cmp')
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end
        },
        window = {
            documentation = {
                max_width = 0
            }
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
        }})
    })
    local lsp = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = {'clangd', 'tailwindcss', 'svelte', 'html', 'cssls'}
    for i = 1, #servers do
        lsp[servers[i]].setup { capabilities = capabilities }
    end
end

function setup(use)
    packer(use)
    theme(use)
    buffer(use)
    status(use)
    explorer(use)
    lsp(use)
end

return manager.startup(setup)
