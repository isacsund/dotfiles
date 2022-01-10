require('lualine').setup {
  options = {
    theme = 'github',
    icons_enabled = false,
  },
  sections = {
    lualine_c = { 'LspStatus()' },
  },
}
