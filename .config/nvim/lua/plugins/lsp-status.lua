local lsp_status = require('lsp-status')

lsp_status.config({
    -- Avoid using use emoji-like or full-width characters
    -- because it can often break rendering within tmux and some terminals
    -- See ~/.vim/plugged/lsp-status.nvim/lua/lsp-status.lua
    indicator_errors = 'E',
    indicator_warnings = 'W',
    indicator_info = 'i',
    indicator_hint = '?',
    indicator_ok = 'Ok',

    -- Automatically sets b:lsp_current_function
    current_function = true,
})
lsp_status.register_progress()

-- LspStatus(): status string for airline
_G.LspStatus = function()
  if #vim.lsp.buf_get_clients() > 0 then
    return lsp_status.status()
  end
  return ''
end
