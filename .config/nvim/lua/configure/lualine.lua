return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "nightfox",
        icons_enabled = false,
      },
    })
  end,
}
