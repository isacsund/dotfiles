require('lspconfig').dockerls.setup({
  on_attach = require('lsp.utils').on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
})
