return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdateSync",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
    })
  end,
}
