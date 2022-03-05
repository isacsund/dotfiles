local null_ls = require('null-ls')
local builtins = null_ls.builtins


local sources = {
  -- Code actions
  builtins.code_actions.shellcheck,

  -- Diagnostics
  builtins.diagnostics.luacheck,
  builtins.diagnostics.shellcheck.with({
    diagnostics_format = '#{m} [#{s}] [#{c}]',
  }),

  -- Formatting
  builtins.formatting.rustfmt,
  builtins.formatting.stylua,
  builtins.formatting.shfmt.with({
    filetypes = { 'sh', 'zsh', 'bash' },
    args = { '-i', '2' },
  }),
}

local config = {
  sources = sources,
  on_attach = require('lsp.utils').on_attach,
  update_on_insert = true,
}

null_ls.setup(config)
