return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    -- catppuccin colorscheme
    use {"catppuccin/nvim", as = "catppuccin"}
    -- buffer indicator
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons'
    }
    require("bufferline").setup({
        options = {show_close_icon = false}
    })
    -- status line
    use 'feline-nvim/feline.nvim'
    vim.opt.termguicolors = true
    require('feline').setup({
        components = require('catppuccin.core.integrations.feline')
    })
    -- file picker
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser<cr>",
                            {noremap = true})
    vim.api.nvim_set_keymap("n", "<space>ff", ":Telescope find_files<cr>",
                            {noremap = true})
    require('telescope').setup()
    require("telescope").load_extension "file_browser"
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
      },
      window = {
        documentation = { max_width = 0 }
      },
      view = { entries = "native" },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources(
        {{ name = 'nvim_lsp' }}, 
        {{ name = 'buffer' }}
      )
    })

    -- Setup lspconfig.
    local lsp = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    servers = {'clangd', 'tailwindcss', 'svelte', 'html', 'cssls', 'dockerls'}
    for i = 1, #servers do
      lsp[servers[i]].setup {capabilities = capabilities}
    end
end)
