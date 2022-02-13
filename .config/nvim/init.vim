set clipboard+=unnamedplus
set number
set mouse=a
set guitablabel=%t
set hidden 
noremap <F2> :bprevious<CR>
noremap <F3> :bnext<CR>
noremap <F4> :bdelete<CR>
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=750
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
filetype plugin on
syntax on
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'evanleck/vim-svelte'
Plug 'francoiscabrol/ranger.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
call plug#end()

let g:svelte_preprocessor_tags = [{ 'name': 'postcss', 'tag': 'style', 'as': 'scss' }]
let g:svelte_preprocessors = ['typescript', 'postcss']

let g:ranger_replace_netrw = 1
let g:ranger_map_keys = 0
nnoremap <Leader>o :Ranger<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :Rg<CR>
nnoremap <F7> :ClangdSwitchSourceHeader<CR>
set completeopt=menu,menuone,noselect

lua << END
-- Lualine setup
require('lualine').setup { options = { theme = 'nord' }}
-- Syntax highlight

-- LSP setup
---- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
---- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
---- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
local lspconfig = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'html', 'tsserver', 'svelte', 'tailwindcss' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities
  }
end
lspconfig.clangd.setup {
  capabilities = capabilities,
  cmd = {
    'clangd',
    '--log=verbose'
  },
}
END
