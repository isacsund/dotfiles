local cmp = require("cmp")
local lspkind = require("lspkind")
lspkind.init()

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
    -- Accept currently selected item.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- Close completion menu
    ["<C-e>"] = cmp.mapping.close(),
    -- Cycle forward
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    -- Cycle backwards
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp', priority = 100 },
    { name = 'path', priority = 30, },
    { name = 'buffer', priority = 10, keyword_length = 5 },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        vsnip = "[snip]",
      },
    },
  },
  experimental = {
    ghost_text = true
  },
}

M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
