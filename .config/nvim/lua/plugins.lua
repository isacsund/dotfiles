require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- VIM enhancements
  use("editorconfig/editorconfig-vim")

  -- GUI enhancements
  use("projekt0n/github-nvim-theme")
  use("nvim-lualine/lualine.nvim")
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  use("nvim-lua/lsp-status.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use("romgrk/barbar.nvim")

  -- Semantic language support
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("nvim-lua/lsp_extensions.nvim")
  use("onsails/lspkind-nvim")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
  })
  use("ray-x/lsp_signature.nvim")
  use("numToStr/Comment.nvim")
  use("jose-elias-alvarez/null-ls.nvim")

  -- Syntactic language support
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
end)

-- Plugin configs
require("plugins/github-theme")
require("plugins/lualine")
require("plugins/gitsigns")
require("plugins/barbar")
require("plugins/lspconfig")
require("plugins/lsp-signature")
require("plugins/lsp-installer")
require("plugins/lsp-status")
require("plugins/cmp")
require("plugins/comments")
require("plugins/null-ls")
require("plugins/treesitter")
