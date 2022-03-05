require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Dependencies of other plugins
  use("nvim-lua/plenary.nvim")

  -- Editing enchancements and tools
  use(require("configure.comment"))
  use(require("configure.telescope"))

  -- LSP + syntax
  use(require("configure.completion"))
  use(require("configure.lspconfig"))
  use(require("configure.luasnip"))
  use(require("configure.treesitter"))

  -- UI + utils
  use(require("configure.barbar"))
  use(require("configure.gitsigns"))
  use(require("configure.nightfox"))
  use(require("configure.notify"))
  use(require("configure.lualine"))
end)
