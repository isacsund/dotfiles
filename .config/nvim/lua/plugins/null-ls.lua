local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.diagnostics.shellcheck.with({
    diagnostics_format = "[#{c}] #{m} (#{s})"
  }),
  null_ls.builtins.code_actions.shellcheck,

  null_ls.builtins.formatting.stylua,
}

null_ls.setup({ sources = sources })
