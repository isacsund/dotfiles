local cmp = require("cmp")
local lspkind = require("lspkind")
lspkind.init()

local M = {}

vim.lsp.protocol.CompletionItemKind = {
  Text = "[text]",
  Method = "[method]",
  Function = "[function]",
  Constructor = "[constructor]",
  Field = "[field]",
  Variable = "[variable]",
  Class = "[class]",
  Interface = "[interface]",
  Module = "[module]",
  Property = "[property]",
  Unit = "[unit]",
  Value = "[value]",
  Enum = "[enum]",
  Keyword = "[key]",
  Snippet = "[snippet]",
  Color = "[color]",
  File = "[file]",
  Reference = "[reference]",
  Folder = "[folder]",
  EnumMember = "[enum member]",
  Constant = "[constant]",
  Struct = "[struct]",
  Event = "[event]",
  Operator = "[operator]",
  TypeParameter = "[type]",
}

-- Better commpletion
-- menuone: popup even when there's only one match
-- noinsert: do not insert text until a selection is made
-- noselect: do not select, force user to select one from the menu
vim.opt.completeopt = "menuone,noinsert,noselect"

cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp.
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- in a clockwise order
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
    { name = "nvim_lsp", priority = 100 },
    { name = "path", priority = 30 },
    { name = "buffer", priority = 10, keyword_length = 5 },
  },
  formatting = {
    format = function(entry, vim_item)
      local menu_map = {
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        vsnip = "[Snip]",
      }
      vim_item.menu = menu_map[entry.source.name] or string.format("[%s]", entry.source.name)

      vim_item.kind = vim.lsp.protocol.CompletionItemKind[vim_item.kind]
      return vim_item
    end,
  },
  experimental = {
    ghost_text = true,
  },
})

M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
