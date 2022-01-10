local cmp = require("cmp")

local M = {}

-- Better commpletion
-- menuone: popup even when there's only one match
-- noinsert: do not insert text until a selection is made
-- noselect: do not select, force user to select one from the menu
vim.opt.completeopt = "menuone,noinsert,noselect"

cmp.setup {
  snippet = {
    -- REQUIRED by nvim-cmp.
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  documentation = {
    border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'}  -- in a clockwise order
  },
   mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  },
  sources = {
    { name = 'nvim_lsp', priority = 100 },
    { name = 'path', priority = 30, },
    { name = 'buffer', priority = 10 },
  },
  experimental = {
    ghost_text = true
  },
}

function M.make_capabilities()
  return require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

return M
