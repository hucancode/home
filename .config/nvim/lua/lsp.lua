local ts = require('nvim-treesitter.configs')
local cmt = require('nvim_comment')
local cmp = require('cmp')
local lsp = require('lspconfig')
local wk = require('which-key')

ts.setup({
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

cmt.setup()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources(
        {{ name = 'nvim_lsp' }}, 
        {{ name = 'buffer' }},
        {{ name = 'omni' }}
    ),
    formatting = {
      format = function(entry, vim_item)
        if vim.tbl_contains({ 'path' }, entry.source.name) then
          local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end
        return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
      end
    },
})
local capabilities = require('cmp_nvim_lsp')
  .default_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = {
  'clangd',
  'html',
  'cssls',
  'tsserver',
  'svelte',
  'tailwindcss',
  'rust_analyzer',
}
for _, server in pairs(servers) do
    lsp[server].setup { capabilities = capabilities }
end
-- I personally think the diagnostic info are distracting
vim.diagnostic.disable()

wk.register({
    g = {
      d = { vim.lsp.buf.definition, 'Go to defination', noremap=true },
      i = { vim.lsp.buf.implementation, 'Go to implementation', noremap=true },
    }
})
