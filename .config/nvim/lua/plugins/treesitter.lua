require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "rust",
    "python",
    "bash",
    "javascript",
  },

  highlight = {
    enable = true,

    disable = { "rust" },
  },
})
