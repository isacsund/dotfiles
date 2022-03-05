return {
  "hrsh7th/nvim-cmp",
  requires = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "onsails/lspkind-nvim",
    "saadparwaiz1/cmp_luasnip",
  },
  after = "LuaSnip",
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })

    local cmp = require("cmp")
    cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = {
        -- Accept currently selected item.
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
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
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer" },
      },
      formatting = {
        format = require("lspkind").cmp_format({ with_text = true, mode = "text" }),
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
