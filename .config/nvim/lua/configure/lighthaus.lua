return {
  "mrjones2014/lighthaus.nvim",
  before = "lualine.nvim",
  config = function()
    require("lighthaus").setup({
      bg_dark = true,
    })
  end,
}
