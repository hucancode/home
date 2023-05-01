local manager = require('packer')

function setup(use)
    use 'wbthomason/packer.nvim'
    use {
        'catppuccin/nvim',
        as = 'catppuccin'
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use 'folke/which-key.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use 'folke/which-key.nvim'
    use 'terrortylor/nvim-comment'
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-omni'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'onsails/lspkind.nvim'
end

return manager.startup(setup)
