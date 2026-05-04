require('mason').setup()
require('mason-lspconfig').setup()

if vim.lsp.config then
    vim.lsp.config('lua_ls', {})
    vim.lsp.config('clangd', {})
else
    require('lspconfig').lua_ls.setup{}
    require('lspconfig').clangd.setup{}
end

require('cmp').setup({
    mapping = require('cmp').mapping.preset.insert({
        ['<C-Space>'] = require('cmp').mapping.complete(),
        ['<CR>']      = require('cmp').mapping.confirm({ select = true }),
    }),
    sources = { { name = 'nvim_lsp' } },
})
