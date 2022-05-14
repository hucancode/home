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
    require('lspconfig').clangd.setup{}
    require('lspconfig').tailwindcss.setup{}
    require('lspconfig').svelte.setup{}
    require('lspconfig').html.setup{}
    require('lspconfig').cssls.setup{}
    require('lspconfig').dockerls.setup{}
end)
