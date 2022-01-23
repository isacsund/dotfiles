local lsp_installer = require("nvim-lsp-installer")
local common_on_attach = require("plugins/lspconfig").common_on_attach
local lsp_opts = require("plugins/lspconfig").lsp_opts
local capabilities = require("plugins/cmp").capabilities

-- Register and activate LSP servers
local lsp_servers = {
  -- List name of LSP servers that will be automatically installed and managed by :LspInstall.
  -- LSP servers will be installed locally at: ~/.local/share/nvim/lsp_servers
  "bashls",
  "dockerls",
  "omnisharp",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
}

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = common_on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }

  -- Customize the options passed to the server
  opts = vim.tbl_extend("error", opts, lsp_opts()[server.name] or {})

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts)
end)

-- Automatically install if a required LSP server is missing.
for _, lsp_name in ipairs(lsp_servers) do
  local ok, lsp = require("nvim-lsp-installer.servers").get_server(lsp_name)

  if ok and not lsp:is_installed() then
    vim.defer_fn(function()
      -- install with a UI so users can be notified
      lsp_installer.install(lsp_name)
    end, 0)
  end
end
